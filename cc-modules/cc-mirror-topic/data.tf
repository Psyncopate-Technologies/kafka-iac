# Fetch environment by display name
data "confluent_environment" "kafka_env" {
  display_name = local.mirror_topic.kafka_cluster.environment_name
}

# Fetch kafka cluster by display name + environment ID
data "confluent_kafka_cluster" "kafka_cluster" {
  display_name   = local.mirror_topic.kafka_cluster.cluster_name
  environment {
    id = data.confluent_environment.kafka_env.id
  }
}
