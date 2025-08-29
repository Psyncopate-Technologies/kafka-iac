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
  source = "git::https://github.com/CenturyLink/kafka-modules.git//cc-modules/cc-client-access?ref=${local.pipeline_version}"

  extra_arguments "Do_not_validate_topic_on_plan" {
    commands = [
      "plan"
    ]

    arguments = [
      "-var=validate_topic_existence=false"
    ]
  }
}

dependency "identity_pool" {
  config_path = "../cc-identity-pool"

  mock_outputs_allowed_terraform_commands = ["init", "validate", "plan"]
  mock_outputs = {
    identity_pool_id = "pool-mock0"
  }
}

locals {
  # Include Common Terragrunt Configs
  terragrunt_configs = read_terragrunt_config(find_in_parent_folders("_common/common_configs.hcl"))
  cloud_provider = local.terragrunt_configs.inputs.cloud_provider
  env = local.terragrunt_configs.inputs.env
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

  producer_client_id_short = "clip"

  producer_client_id = (can(coalesce(local.app_config.producer.client_id)) ? local.app_config.producer.client_id :
    "${local.cloud_provider_short}-${local.producer_client_id_short}-${local.env_short}-${local.env_cat_short}-${local.name}-01")
  producer_topics    = (local.app_config.producer.topics[*].name)
  transactional_enabled = try(local.app_config.producer.transactional.enabled, false)

  # Derive transaction_id only if enabled
  transaction_id = local.transactional_enabled ? replace(local.producer_client_id, "clip", "trx") : null

  consumer_client_id = local.app_config.consumer.client_id
  consumer_group_id  = local.app_config.consumer.group_id
  consumer_topics    = (local.app_config.consumer.topics[*].name)

  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "app-resources/${local.name}.tfstate"
  # select backend template based on mode
  backend_template      = local.is_tfstate_local == "false" ? local.backend_config_common.locals.backend_common[local.cloud_provider].template : local.backend_config_common.locals.backend_common["local"].template
  backend_config        = format(local.backend_template, local.is_tfstate_local == "false" ? "${local.env}/${local.backend_key_suffix}" : "${get_terragrunt_dir()}/terraform.tfstate")
}

inputs = {
  producer_client_id = local.producer_client_id
  producer_topics    = local.producer_topics
  transaction_id     = local.transaction_id

  consumer_client_id = local.consumer_client_id
  consumer_group_id  = local.consumer_group_id
  consumer_topics    = local.consumer_topics

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
output "producer_topic_role_bindings" {
  value = [ for producer_rbs in confluent_role_binding.producer_topic_role_bindings : producer_rbs.id ]
}
output "consumer_topic_role_bindings" {
  value = [ for consumer_rbs in confluent_role_binding.consumer_topic_role_bindings : consumer_rbs.id ]
}
output "consumer_group_role_bindings" {
  value = confluent_role_binding.consumer_group_role_bindings.id
}
EOF
}
