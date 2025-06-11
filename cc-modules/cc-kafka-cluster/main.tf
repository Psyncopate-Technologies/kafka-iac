locals {
  cluster_cloud_prefix = lower(substr(var.cloud_provider, 0, 3))
  cluster_name         = "${local.cluster_cloud_prefix}-clstr-${var.environment_name}-${var.cloud_region}-${tostring(var.cluster_number)}"
}

data "confluent_environment" "cc_environment" {
  id = var.confluent_cloud_environment_id
}

data "confluent_network" "cc_network" {
  id = var.confluent_cloud_network_id

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