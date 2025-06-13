locals {
  module_repo_version_tag = "" # Update this tag when versioning the module
}

module "cc-environment" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-environment?ref=${local.module_repo_version_tag}" 

  environment_name           = var.environment_name
  stream_governance_package  = var.stream_governance_package
}
