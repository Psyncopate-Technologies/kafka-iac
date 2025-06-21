module "cc-environment" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-environment?ref=<INSERT module_repo_version_tag VARIABLE HERE>" 

  module_repo_version_tag = <INSERT module_repo_version_tag VARIABLE HERE>

  cloud_provider             = var.cloud_provider
  environment_name           = var.environment_name
  cloud_region               = var.cloud_region
  environment_number         = var.environment_number
  stream_governance_package  = var.stream_governance_package
}