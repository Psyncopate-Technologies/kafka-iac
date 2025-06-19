module "cc-kafka-cluster" {
  # Update module_repo_version_tag here for ref
  source = "github.com/CenturyLink/kafka-modules/cc-modules/cc-kafka-cluster?ref=<INSERT module_repo_version_tag VARIABLE HERE>"

  module_repo_version_tag = <INSERT module_repo_version_tag VARIABLE HERE>

  confluent_cloud_environment_name = var.confluent_cloud_environment_name
  confluent_cloud_network_name     = var.confluent_cloud_network_name

  cloud_provider = var.cloud_provider
  cloud_region   = var.cloud_region

  environment_name = var.environment_name

  cluster_number               = var.cluster_number
  cluster_multi_zone_available = var.cluster_multi_zone_available
  cluster_ckus                 = var.cluster_ckus
}