resource "confluent_kafka_cluster" "this" {
  display_name = local.cluster_name

  cloud        = upper(var.cloud_provider)
  region       = var.cloud_region
  availability = var.cluster_multi_zone_available ? "MULTI_ZONE" : "SINGLE_ZONE"

  dedicated {
    cku = var.cluster_ckus
  }

  environment {
    id = data.confluent_environment.cc_environment.id
  }

  network {
    id = data.confluent_network.cc_network.id
  }

  lifecycle {
    prevent_destroy = true
  }
}