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
  env_cat = local.terragrunt_configs.inputs.env_category
  topic_config_raw       = local.terragrunt_configs.inputs.resource_config_raw
  topic_path             = local.terragrunt_configs.inputs.resource_path
  is_tfstate_local       = local.terragrunt_configs.inputs.is_tfstate_local
  iac_version            = local.terragrunt_configs.inputs.pipeline_version

  raw_replications       = local.topic_config_raw.replication
  topic_name             = local.topic_config_raw.topic.name

  prev_status_map = try(
  read_terragrunt_config(find_in_parent_folders("previous_status.hcl")).inputs.prev_status_map,
  {}  # default empty map if file not found
)

  allowed_transitions = {
    "ACTIVE"      = ["ACTIVE", "PROMOTED", "FAILED_OVER", "PAUSED"]
    "PAUSED"      = ["ACTIVE", "PAUSED"]
    "PROMOTED"    = ["PROMOTED"]  # No changes allowed
    "FAILED_OVER" = ["FAILED_OVER"]  # No changes allowed
  }

  # Only keep replication entries with valid transitions
  valid_replications = {
    for r in local.raw_replications :
    "${r.target_provider}-${r.target_kafka_cluster_region}" => r
    if contains(local.allowed_transitions[lookup(local.prev_status_map, "${r.target_provider}-${r.target_kafka_cluster_region}", "ACTIVE")], lookup(r, "status", "ACTIVE")) ||
       lookup(local.prev_status_map, "${r.target_provider}-${r.target_kafka_cluster_region}", "ACTIVE") == lookup(r, "status", "ACTIVE")
  }

  terragrunt_inputs = read_terragrunt_config(find_in_parent_folders("_common/common_inputs.hcl"))
  tc_api_key       = local.terragrunt_inputs.inputs.cc_target_cluster_api_key
  tc_api_secret    = local.terragrunt_inputs.inputs.cc_target_cluster_api_secret

  cloud_provider_short = (local.cloud_provider == "azure") ? "azu" : (
    (local.cloud_provider == "aws") ? "aws" : (
    (local.cloud_provider == "gcp") ? "gcp" : ""))

  env_short = (local.env == "dev") ? "d" : (
    (local.env == "test") ? "t" : (
    (local.env == "prod") ? "p" : ""))

  env_cat_short = (local.env_cat == "commercial") ? "com" : ((local.env_cat == "federal") ? "flz" : "")

  cluster_constant = "kafka-enterprise-kafka"
  environment_name_constant = "env-enterprise-kafka"

  replications_map = {
    for r in local.valid_replications :
    "${r.target_provider}-${r.target_kafka_cluster_region}" => {
      mirror_topic_status = lookup(r, "status", "ACTIVE")
      mirror_topic_name   = "${local.env}-${r.target_provider}-${r.target_kafka_cluster_region}-${local.topic_name}"
      cluster_link_name   = "${local.env}-${r.target_provider}-${r.target_kafka_cluster_region}-link"
      target_cluster_name = "${local.cloud_provider_short}-${local.cluster_constant}-${local.env_short}-${local.env_cat_short}-${r.target_kafka_cluster_region}-01"
      target_env_name     = "${local.cloud_provider_short}-${local.environment_name_constant}-${local.env_short}-${local.env_cat_short}-${r.target_kafka_cluster_region}-01"
    }
  }
  
  # Include Backend Configurations
  backend_config_common = read_terragrunt_config(find_in_parent_folders("_common/backend_configs.hcl"))
  backend_key_suffix    = "mirror-topics/${local.topic_name}.tfstate"
  backend_template      = local.is_tfstate_local == "false" ? local.backend_config_common.locals.backend_common[local.cloud_provider].template : local.backend_config_common.locals.backend_common["local"].template
  backend_config        = format(local.backend_template, local.is_tfstate_local == "false" ? "${local.env}/${local.backend_key_suffix}" : "${get_terragrunt_dir()}/terraform.tfstate")
}

terraform {
  source = "../../../cc-modules/cc-mirror-topic"
}

inputs = {
  replications              = local.replications_map
  source_topic_name         = local.topic_name
  target_cluster_api_key    = local.tc_api_key
  target_cluster_api_secret = local.tc_api_secret
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

output "mirror_topic_names" {
  value       = { for k, v in local.replications_map : k => v.mirror_topic_name }
  description = "Derived mirror topic names for each replication."
}
EOF
}