# Fetch environment by display name
data "confluent_environment" "kafka_env" {
  display_name = var.target_env_name
}

# Fetch kafka cluster by display name + environment ID
data "confluent_kafka_cluster" "kafka_cluster" {
  display_name   = var.target_cluster_name
  environment {
    id = data.confluent_environment.kafka_env.id
  }
}
