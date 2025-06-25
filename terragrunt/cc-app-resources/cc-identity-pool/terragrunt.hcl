include "common" {
  path = find_in_parent_folders("_common/common.hcl")
}

include "common_provider" {
  path = find_in_parent_folders("_common/providers.hcl")
}

terraform {
  source = "../../../cc-modules/cc-identity-pool"
  # source = "git::https://${get_env("GITHUB_TOKEN")}@github.com/Psyncopate-Technologies/kafka-iac.git//cc-modules/cc-client-quota?ref=${local.iac_version}"
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
output "identity_pool_id" {
  value = confluent_identity_pool.identity_pool.id
}
EOF
}

