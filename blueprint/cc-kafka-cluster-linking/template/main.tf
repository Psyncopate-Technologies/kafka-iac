module "cc-kafka-cluster-linking" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-kafka-cluster-link?ref=cc-cluster-link"

  providers = {
    confluent.local  = confluent.local
    confluent.remote = confluent.remote
  }
  confluent_cloud_api_key     = var.confluent_cloud_api_key
  confluent_cloud_api_secret  = var.confluent_cloud_api_secret
  link_name                   = var.link_name
  linker_service_account_name = var.linker_service_account_name

  local_environment_name      = var.local_environment_name
  remote_environment_name     = var.remote_environment_name

  local_kafka_cluster_name    = var.local_kafka_cluster_name
  remote_kafka_cluster_name   = var.remote_kafka_cluster_name
}
