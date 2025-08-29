# Common Terragrunt Configurations - Will be used in independent module's terragrunt.hcl file
locals {
  cloud_provider      = get_env("CLOUD_PROVIDER")
  env                 = get_env("ENV")
  env_category        = get_env("ENV_CATEGORY")
  is_tfstate_local    = get_env("IS_TF_STATE_LOCAL")
  file_name           = get_env("FILE_NAME")
  
  # The pipeline now copies the resource file to the working directory
  resource_path       = "${get_original_terragrunt_dir()}/${get_env("FILE_NAME")}"
    
  resource_config_raw = yamldecode(file(local.resource_path))
}

inputs = {
  cloud_provider      = local.cloud_provider
  env                 = local.env
  env_category        = local.env_category
  is_tfstate_local    = local.is_tfstate_local
  resource_path       = local.resource_path
  resource_config_raw = local.resource_config_raw
  pipeline_version    = try(local.resource_config_raw.pipeline_version, "latest")
}