# Logic for mirror topics
include "common" {
  path = find_in_parent_folders("_common/common_inputs.hcl")
}

include "providers" {
  path = find_in_parent_folders("_common/providers.hcl")
}

include "errors" {
  path = find_in_parent_folders("_common/retry_errors.hcl")
}

locals {
  # Include Common Terragrunt Configs
  terragrunt_configs     = read_terragrunt_config(find_in_parent_folders("_common/common_configs.hcl"))
  cloud_provider         = local.terragrunt_configs.inputs.cloud_provider
  env                    = local.terragrunt_configs.inputs.env
  mirror_topic_config_raw = local.terragrunt_configs.inputs.resource_config_raw
  mirror_topic_path      = local.terragrunt_configs.inputs.resource_path
  is_tfstate_local       = local.terragrunt_configs.inputs.is_tfstate_local
  iac_version            = local.terragrunt_configs.inputs.pipeline_version

  # Parse mirror topic details from YAML
  mirror_topic_name   = local.mirror_topic_config_raw.mirror_topic_name
  source_topic_name   = local.mirror_topic_config_raw.source_kafka_topic.topic_name
  cluster_link_name   = local.mirror_topic_config_raw.cluster_link.link_name
  target_cluster_name = local.mirror_topic_config_raw.kafka_cluster.cluster_name
  target_env_name     = local.mirror_topic_config_raw.kafka_cluster.environment_name
  mirror_topic_status = local.mirror_topic_config_raw.status
  delete_after_migration = local.mirror_topic_config_raw.delete_after_migration

  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "mirror-topics/${local.mirror_topic_name}.tfstate"
  backend_template      = local.is_tfstate_local == "false" ? local.backend_config_common.locals.backend_common[local.cloud_provider].template : local.backend_config_common.locals.backend_common["local"].template
  backend_config        = format(local.backend_template, local.is_tfstate_local == "false" ? "${local.env}/${local.backend_key_suffix}" : "${get_terragrunt_dir()}/terraform.tfstate")
}

terraform {
  source = "/Users/shravyagennepally/Desktop/git/kafka-iac/cc-modules/cc-mirror-topic"
}

inputs = {
  mirror_topic_path       = local.mirror_topic_path
  mirror_topic_config_raw = local.mirror_topic_config_raw
  mirror_topic_name       = local.mirror_topic_name
  source_topic_name       = local.source_topic_name
  cluster_link_name       = local.cluster_link_name
  target_cluster_name     = local.target_cluster_name
  target_env_name         = local.target_env_name
  mirror_topic_status     = local.mirror_topic_status
  delete_after_migration  = local.delete_after_migration
}

#generate "backend" {
 # path      = "backend.tf"
 # if_exists = "overwrite"
  #contents  = local.backend_config
#}

generate "outputs" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents  = <<EOF
output "pipeline_version" {
  value       = "${local.iac_version}"
  description = "The version of the IaC module that was applied."
}
EOF
}
