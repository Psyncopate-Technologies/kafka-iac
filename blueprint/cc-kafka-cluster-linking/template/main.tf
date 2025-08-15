module "cc-kafka-cluster-linking" {
  #source = "github.com/CenturyLink/kafka-modules/cc-modules/cc-kafka-cluster?ref=<INSERT module_repo_version_tag VARIABLE HERE>"
source = "/Users/shravyagennepally/Desktop/git/kafka-iac/cc-modules/cc-kafka-cluster-link"
  #module_repo_version_tag = <INSERT module_repo_version_tag VARIABLE HERE>

  link_name                   = var.link_name
  linker_service_account_name = var.linker_service_account_name

  local_environment_name      = var.local_environment_name
  remote_environment_name     = var.remote_environment_name

  local_kafka_cluster_name    = var.local_kafka_cluster_name
  remote_kafka_cluster_name   = var.remote_kafka_cluster_name
}