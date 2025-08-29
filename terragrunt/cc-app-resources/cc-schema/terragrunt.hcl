# Logic for schema
include "common" {
  path = find_in_parent_folders("_common/common_inputs.hcl")
}

include "providers" {
  path = find_in_parent_folders("_common/providers.hcl")
}

locals {
  # Include Common Terragrunt Configs
  terragrunt_configs = read_terragrunt_config(find_in_parent_folders("_common/common_configs.hcl"))
  cloud_provider = local.terragrunt_configs.inputs.cloud_provider
  env = local.terragrunt_configs.inputs.env
  schema_config_raw = local.terragrunt_configs.inputs.resource_config_raw
  schema_path = local.terragrunt_configs.inputs.resource_path
  is_tfstate_local = local.terragrunt_configs.inputs.is_tfstate_local
  iac_version = local.terragrunt_configs.inputs.pipeline_version
  
  # Include Module specific configs
  terragrunt_inputs = read_terragrunt_config(find_in_parent_folders("_common/common_inputs.hcl"))
  first_schema     = local.schema_config_raw.schema[0]
  topic_name       = local.first_schema.topic_name
  schema_type      = local.first_schema.schema_type
  subject_name     = "${local.topic_name}-${local.schema_type}"
  schema_registry_rest_endpoint = local.terragrunt_inputs.inputs.cc_sr_endpoint
  schema_registry_api_key       = local.terragrunt_inputs.inputs.cc_sr_api_key
  schema_registry_api_secret    = local.terragrunt_inputs.inputs.cc_sr_api_secret
  schema_format                 = local.first_schema.format
  schema_file_path              = local.first_schema.file_name
  environment_name = local.terragrunt_inputs.inputs.environment_name

  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "schemas/${local.subject_name}.tfstate"
  backend_template      = local.backend_config_common.locals.backend_common[local.cloud_provider].template
  backend_config        = format(local.backend_template, "${local.env}/${local.backend_key_suffix}")

}

terraform {
  source = "git::https://github.com/CenturyLink/kafka-modules.git//cc-modules/cc-schema?ref=${local.iac_version}"
  
  # Copy schema files BEFORE plan/apply/destroy when they're needed
  # The working directory for terraform commands is the cache directory
  # Schemas are in the parent directory (client_MAL1/schemas), not in cc-schema/schemas
  before_hook "copy_schemas" {
    commands = ["plan", "apply", "destroy"]
    execute  = ["bash", "-c", "PARENT_DIR=$(dirname '${get_original_terragrunt_dir()}') && echo \"Looking for schemas in: $PARENT_DIR/schemas\" && if [ -d \"$PARENT_DIR/schemas\" ]; then cp -r \"$PARENT_DIR/schemas\" . && echo 'Schemas copied successfully' && ls -la schemas/; else echo \"No schemas directory found at $PARENT_DIR/schemas\"; fi"]
    run_on_error = false
  }
}

inputs = {
  schema_registry_rest_endpoint = local.schema_registry_rest_endpoint
  schema_registry_api_key       = local.schema_registry_api_key
  schema_registry_api_secret    = local.schema_registry_api_secret
  subject_name                  = local.subject_name
  schema_format                 = local.schema_format
  schema_file_path              = local.schema_file_path
  env_name                      = local.environment_name
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = local.is_tfstate_local == "false" ? local.backend_config : ""
}

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

