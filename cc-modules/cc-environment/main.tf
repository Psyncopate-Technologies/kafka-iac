resource "confluent_environment" "this" {
  display_name = var.environment_name

  lifecycle {
    prevent_destroy = true
  }
}

resource "confluent_schema_registry_cluster" "this" {
  depends_on = [confluent_environment.this]

  schema_registry_cluster {
    id = "lsrc-"
  }

  environment {
    id = confluent_environment.this.id
  }

  package = var.schema_registry_package

  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }

  rest_endpoint = var.kafka_rest_endpoint
}
