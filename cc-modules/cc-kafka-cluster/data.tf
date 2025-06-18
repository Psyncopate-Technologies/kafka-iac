data "confluent_environment" "cc_environment" {
  display_name = var.confluent_cloud_environment_name
}

data "confluent_network" "cc_network" {
  display_name = var.confluent_cloud_network_name

  environment {
    id = data.confluent_environment.cc_environment.id
  }
}

data "confluent_schema_registry_cluster" "cc_schema_registry" {
  environment {
    id = data.confluent_environment.cc_environment.id
  }
}