include "common" {
  path = find_in_parent_folders("_common/common.hcl")
}

include "providers" {
  path = find_in_parent_folders("_common/providers.hcl")
}

locals {
  cloud_provider = get_env("CLOUD_PROVIDER", "azure")
  env            = get_env("ENV", "dev")
  topic_path     = "${get_terragrunt_dir()}/MirrorTopicAlias1.yaml"

  mirror_topic_config_raw = yamldecode(file(local.topic_path))
  mirror_topic_name       = local.mirror_topic_config_raw.mirror_topic.mirror_topic_name
  iac_version             = try(local.mirror_topic_config_raw.pipeline_version, "latest")

  backend_config = (
    local.cloud_provider == "azure" ? <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "${get_env("AZURE_RESOURCE_GROUP_NAME", "psy-flink-poc")}"
    storage_account_name = "${get_env("AZURE_STORAGE_ACCOUNT_NAME", "psyflinkops")}"
    container_name       = "${get_env("AZURE_STORAGE_CONTAINER_NAME", "psyflinkcontainer")}"
    key                  = "${local.env}/mirror-topics/${local.mirror_topic_name}.tfstate"
  }
}
EOF
  : error("Unsupported cloud_provider: ${local.cloud_provider}")
  )
}

terraform {
  source = "git::https://${get_env("GITHUB_TOKEN")}@github.com/Psyncopate-Technologies/kafka-iac.git//cc-modules/cc-kafka-mirror-topic?ref=${local.iac_version}"
}

inputs = {
  mirror_topic_config_raw = local.mirror_topic_config_raw
  mirror_topic_name       = local.mirror_topic_name
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = local.backend_config
}

generate "outputs" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents  = <<EOF
output "pipeline_version" {
  value       = "${local.iac_version}"
  description = "The version of the IaC module that was applied."
}
output "mirror_topic_id" {
  value       = confluent_kafka_mirror_topic.this.id
  description = "The ID of the mirror topic created"
}
EOF
}
