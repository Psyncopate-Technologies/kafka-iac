resource "confluent_cluster_link" "this" {
  link_name = var.link_name != null ? var.link_name : local.default_link_name
  link_mode = var.link_mode

  local_kafka_cluster {
    id            = var.local_cluster_id
    rest_endpoint = var.local_rest_endpoint
    credentials {
      key    = var.local_api_key_id
      secret = var.local_api_key_secret
    }
  }

  remote_kafka_cluster {
    id                 = var.remote_cluster_id
    bootstrap_endpoint = var.remote_bootstrap
    credentials {
      key    = var.remote_api_key_id
      secret = var.remote_api_key_secret
    }
  }

  lifecycle {
    prevent_destroy = true
  }
}
