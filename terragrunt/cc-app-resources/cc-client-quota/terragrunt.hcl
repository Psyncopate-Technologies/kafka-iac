include "common" {
  path = find_in_parent_folders("_common/common_inputs.hcl")
}

include "common_provider" {
  path = find_in_parent_folders("_common/providers.hcl")
}

include "errors" {
  path = find_in_parent_folders("_common/retry_errors.hcl")
}

terraform {
  source = "git::https://github.com/CenturyLink/kafka-modules.git//cc-modules/cc-client-quota?ref=${local.pipeline_version}"
}

dependency "identity_pool" {
  config_path = "../cc-identity-pool"

  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    pipeline_version = "1.0.0"
    identity_pool_id = "pool-mock0"
  }
}

locals {
  # Include Common Terragrunt Configs
  terragrunt_configs = read_terragrunt_config(find_in_parent_folders("_common/common_configs.hcl"))
  cloud_provider = local.terragrunt_configs.inputs.cloud_provider
  env = local.terragrunt_configs.inputs.env
  env_cat = local.terragrunt_configs.inputs.env_category
  app_resources_path = local.terragrunt_configs.inputs.resource_path
  app_config = local.terragrunt_configs.inputs.resource_config_raw
  is_tfstate_local = local.terragrunt_configs.inputs.is_tfstate_local
  pipeline_version = local.terragrunt_configs.inputs.pipeline_version
  name             = basename(dirname(abspath(local.app_resources_path)))

  cloud_provider_short = (local.cloud_provider == "azure") ? "azu" : (
    (local.cloud_provider == "aws") ? "aws" : (
    (local.cloud_provider == "gcp") ? "gcp" : ""))

  env_short = (local.env == "dev") ? "d" : (
    (local.env == "test") ? "t" : (
    (local.env == "prod") ? "p" : ""))

  env_cat_short = (local.env_cat == "commercial") ? "com" : ((local.env_cat == "federal") ? "flz" : "")

  client_quota_short = "qt"

  quota_name        = (can(coalesce(local.app_config.quota.name)) ? local.app_config.quota.name :
    "${local.cloud_provider_short}-${local.client_quota_short}-${local.name}-${local.env_short}-${local.env_cat_short}-01")
  ingress_byte_rate = tonumber(try(local.app_config.quota.ingress_byte_rate, 1000000))
  egress_byte_rate  = tonumber(try(local.app_config.quota.egress_byte_rate, 1000000))


  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "app-resources/${local.name}.tfstate"
  # select backend template based on mode
  backend_template      = local.is_tfstate_local == "false" ? local.backend_config_common.locals.backend_common[local.cloud_provider].template : local.backend_config_common.locals.backend_common["local"].template
  backend_config        = format(local.backend_template, local.is_tfstate_local == "false" ? "${local.env}/${local.backend_key_suffix}" : "${get_terragrunt_dir()}/terraform.tfstate")
}

inputs = {
  quota_name        = local.quota_name
  ingress_byte_rate = local.ingress_byte_rate
  egress_byte_rate  = local.egress_byte_rate
  identity_pool_id  = dependency.identity_pool.outputs.identity_pool_id
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
  value       = "${local.pipeline_version}"
  description = "The version of the IaC module that was applied."
}
output "client_quota_id" {
  value = confluent_kafka_client_quota.client_quota.id
}
EOF
}

