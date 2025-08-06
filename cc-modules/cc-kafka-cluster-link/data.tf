# Get local cluster info using ID and environment ID
data "confluent_kafka_cluster" "local" {
  id = var.local_cluster_id

  environment {
    id = var.local_environment_id
  }
}

# Get remote cluster info using ID and environment ID
data "confluent_kafka_cluster" "remote" {
  id = var.remote_cluster_id

  environment {
    id = var.remote_environment_id
  }
}
