data "confluent_environment" "local" {
  display_name = var.local_environment_name
}

data "confluent_environment" "remote" {
  display_name = var.remote_environment_name
}

data "confluent_kafka_cluster" "local" {
  display_name = var.local_kafka_cluster_name

  environment {
    id = data.confluent_environment.local.id
  }
}

data "confluent_kafka_cluster" "remote" {
  display_name = var.remote_kafka_cluster_name

  environment {
    id = data.confluent_environment.remote.id
  }
}
