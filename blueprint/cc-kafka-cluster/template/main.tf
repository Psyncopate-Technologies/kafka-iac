locals {
  module_repo_version_tag = "" # Update to the module repo version tag
}

module "cc-kafka-cluster" {
  source = "github.com/CenturyLink/kafka-modules/cc-modules/cc-kafka-cluster?ref=<INSERT module_repo_version_tag>" # Update module_repo_version_tag here

  module_repo_version_tag = local.module_repo_version_tag

  confluent_cloud_environment_name = var.confluent_cloud_environment_name
  confluent_cloud_network_name     = var.confluent_cloud_network_name

  cloud_provider = var.cloud_provider
  cloud_region   = var.cloud_region

  environment_name = var.environment_name

  cluster_number               = var.cluster_number
  cluster_multi_zone_available = var.cluster_multi_zone_available
  cluster_ckus                 = var.cluster_ckus
}