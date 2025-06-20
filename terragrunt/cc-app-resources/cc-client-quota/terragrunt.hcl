include "common" {
  path = find_in_parent_folders("_common/common.hcl")
}

include "common_provider" {
  path = find_in_parent_folders("_common/providers.hcl")
}

terraform {
  source = "../../../cc-modules/cc-client-quota"
  # source = "git::https://${get_env("GITHUB_TOKEN")}@github.com/Psyncopate-Technologies/kafka-iac.git//cc-modules/cc-client-quota?ref=${local.iac_version}"
}

dependency "identity_pool" {
  config_path = "../cc-identity-pool"
  skip_outputs = true
}

locals {
  app_resources_path = "${get_terragrunt_dir()}/${get_env("FILE_NAME")}"

  # Use pipeline_version if present, otherwise default to "latest"
  iac_version = "latest"
}

inputs = {
  app_resources_path = local.app_resources_path
}

generate "outputs" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents  = <<EOF
output "client_quota_id" {
  value = confluent_kafka_client_quota.client_quota.id
}
EOF
}

