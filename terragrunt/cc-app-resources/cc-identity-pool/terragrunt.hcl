include "common" {
  path = find_in_parent_folders("_common/common_inputs.hcl")
}

include "common_provider" {
  path = find_in_parent_folders("_common/providers.hcl")
}

include "errors" {
  path = find_in_parent_folders("_common/retry_errors.hcl")
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

  identity_provider_type_short = "entra"

  identity_pool_short = "idpool"
  identity_provider_short = "idp"

  identity_pool_name     = (can(coalesce(local.app_config.identity_pool_name)) ? local.app_config.identity_pool_name :
    "${local.cloud_provider_short}-${local.identity_pool_short}-${local.name}-${local.env_short}-${local.env_cat_short}-01")
  identity_provider_name = (can(coalesce(local.app_config.identity_provider_name)) ? local.app_config.identity_provider_name :
    "${local.cloud_provider_short}-${local.identity_provider_short}-${local.identity_provider_type_short}-enterprise-kafka-${local.env_short}-${local.env_cat_short}-01")
  oauth_client_id        = local.app_config.oauth_client_id

  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "app-resources/${local.name}.tfstate"
  # select backend template based on mode
  backend_template      = local.is_tfstate_local == "false" ? local.backend_config_common.locals.backend_common[local.cloud_provider].template : local.backend_config_common.locals.backend_common["local"].template
  backend_config        = format(local.backend_template, local.is_tfstate_local == "false" ? "${local.env}/${local.backend_key_suffix}" : "${get_terragrunt_dir()}/terraform.tfstate")
}

terraform {
  source = "git::https://github.com/CenturyLink/kafka-modules.git//cc-modules/cc-identity-pool?ref=${local.pipeline_version}"
}

inputs = {
  identity_pool_name     = local.identity_pool_name
  identity_provider_name = local.identity_provider_name
  oauth_client_id        = local.oauth_client_id
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
output "identity_pool_id" {
  value = confluent_identity_pool.identity_pool.id
}
EOF
}

