data "confluent_environment" "cc_environment" {
  display_name = var.environment_name
}

data "confluent_kafka_cluster" "cc_kafka_cluster" {
  display_name = var.cc_kafka_cluster_name
  environment {
    id = data.confluent_environment.cc_environment.id
  }
}

data "confluent_schema_registry_cluster" "cc_sr_cluster" {
  environment {
    id = data.confluent_environment.cc_environment.id
  }
}