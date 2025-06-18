locals {
  cluster_cloud_prefix = lower(substr(var.cloud_provider, 0, 3))
  cluster_name         = "${local.cluster_cloud_prefix}-clstr-${substr(var.environment_name, 0, 1)}-${var.cloud_region}-${format("%02d", var.cluster_number)}"
}

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