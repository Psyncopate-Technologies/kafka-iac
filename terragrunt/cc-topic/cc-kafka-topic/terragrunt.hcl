# Logic for topics
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
  terragrunt_configs = read_terragrunt_config(find_in_parent_folders("_common/common_configs.hcl"))
  cloud_provider = local.terragrunt_configs.inputs.cloud_provider
  env = local.terragrunt_configs.inputs.env
  topic_config_raw = local.terragrunt_configs.inputs.resource_config_raw
  topic_path = local.terragrunt_configs.inputs.resource_path
  is_tfstate_local = local.terragrunt_configs.inputs.is_tfstate_local
  iac_version = local.terragrunt_configs.inputs.pipeline_version
  
  # Include Module specific configs
  # Parse topic name from YAML (assumes only one topic)
  topic_name       = local.topic_config_raw.topic.name
  # Retrieve ClientMAL and SRB#
  clientMAL = local.topic_config_raw.topic.mal_acronym
  srb_review_number = local.topic_config_raw.topic.srb_review_number
  sec_review_number = try(local.topic_config_raw.topic.sec_review_number, "")
  # Define environment-specific defaults
  #default_partitions = local.env == "dev" ? 3 : local.env == "test" ? 6 : 6
  default_partitions = get_env("DEFAULT_PATITION_COUNT")

  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "topics/${local.topic_name}.tfstate"
  # select backend template based on mode
  backend_template      = local.is_tfstate_local == "false" ? local.backend_config_common.locals.backend_common[local.cloud_provider].template : local.backend_config_common.locals.backend_common["local"].template
  backend_config        = format(local.backend_template, local.is_tfstate_local == "false" ? "${local.env}/${local.backend_key_suffix}" : "${get_terragrunt_dir()}/terraform.tfstate")

}

terraform {
  source = "git::https://github.com/CenturyLink/kafka-modules.git//cc-modules/cc-kafka-topic?ref=${local.iac_version}"

  before_hook "check_tag_existence" {
    commands = ["plan", "apply"]
    execute  = [
      "bash",
      "${get_terragrunt_dir()}/validation/check_tag_existence.sh",
      (
        get_env("CC_SR_API_KEY", "") != "" ? get_env("CC_SR_API_KEY") :
        get_env("CLOUD_PROVIDER") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", "${upper(get_env("CLOUD_PROVIDER"))}-CC-SR-API-KEY-APP-${upper(get_env("ENV"))}", "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
        ""
      ),
      (
        get_env("CC_SR_API_SECRET", "") != "" ? get_env("CC_SR_API_SECRET") :
        get_env("CLOUD_PROVIDER") == "azure" ? regex("^.(.*).$", run_cmd("--terragrunt-quiet", "az", "keyvault", "secret", "show", "--name", "${upper(get_env("CLOUD_PROVIDER"))}-CC-SR-API-SECRET-APP-${upper(get_env("ENV"))}", "--vault-name", get_env("AZURE_KEYVAULT_NAME"), "--query", "value"))[0] :
        ""
      ),
      get_env("CC_SR_ENDPOINT"),
      local.clientMAL,
      local.srb_review_number,
      local.sec_review_number
    ]
  }
  
}

inputs = {
  topic_path           = local.topic_path
  topic_config_raw     = local.topic_config_raw
  topic_name           = local.topic_name # Explicitly passing this as input so as to validate the naming convention of it in variables.tf
  default_partitions   = local.default_partitions
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
output "topic_id" {
  value = confluent_kafka_topic.cc_kafka_topic.id
  description = "The ID of the Topic being created in Confluent Cloud"
}
EOF
}

