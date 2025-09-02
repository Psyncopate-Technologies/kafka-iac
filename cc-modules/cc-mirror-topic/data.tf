# Fetch environment by display name
data "confluent_environment" "kafka_env" {
  for_each     = var.replications
  display_name = each.value.target_env_name
}

# Fetch Kafka cluster by display name + environment ID
data "confluent_kafka_cluster" "kafka_cluster" {
  for_each      = var.replications
  display_name  = each.value.target_cluster_name
  environment {
    id = data.confluent_environment.kafka_env[each.key].id
  }
}
