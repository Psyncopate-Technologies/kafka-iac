data "confluent_kafka_cluster" "local" {
  display_name = var.local_cluster_name
  environment {
    id = var.environment_id
  }
}

data "confluent_kafka_cluster" "remote" {
  display_name = var.remote_cluster_name
  environment {
    id = var.environment_id
  }
}