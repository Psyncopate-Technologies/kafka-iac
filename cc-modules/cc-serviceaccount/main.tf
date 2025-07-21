terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "~> 2.32.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

# Create service account for cluster linking
resource "confluent_service_account" "linker" {
  display_name = "${var.link_name}-linker"
  description  = "SA for Cluster Linking"
}

# Role Binding: Needed to allow cluster link creation (CloudClusterAdmin minimum for cluster scope)
resource "confluent_role_binding" "linker_binding" {
  principal   = "User:${confluent_service_account.linker.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = var.local_cluster_rbac_crn
}

# API key for local cluster
resource "confluent_api_key" "local" {
  display_name = "${var.link_name}-local-api-key"
  description  = "API Key for local cluster access"

  owner {
    id          = confluent_service_account.linker.id
    api_version = "iam/v2"
    kind        = "ServiceAccount"
  }

  managed_resource {
    id          = var.local_cluster_id
    api_version = "cmk/v2"
    kind        = "Cluster"
    environment {
      id = var.environment_id
    }
  }

  depends_on = [confluent_role_binding.linker_binding]
}

# API key for remote cluster
resource "confluent_api_key" "remote" {
  display_name = "${var.link_name}-remote-api-key"
  description  = "API Key for remote cluster access"

  owner {
    id          = confluent_service_account.linker.id
    api_version = "iam/v2"
    kind        = "ServiceAccount"
  }

  managed_resource {
    id          = var.remote_cluster_id
    api_version = "cmk/v2"
    kind        = "Cluster"
    environment {
      id = var.environment_id
    }
  }

  depends_on = [confluent_role_binding.linker_binding]
}

# Cluster Link
resource "confluent_cluster_link" "this" {
  link_name = var.link_name
  link_mode = "BIDIRECTIONAL"

  local_kafka_cluster {
    id            = var.local_cluster_id
    rest_endpoint = var.local_rest_endpoint
    credentials {
      key    = confluent_api_key.local.id
      secret = confluent_api_key.local.secret
    }
  }

  remote_kafka_cluster {
    id                 = var.remote_cluster_id
    bootstrap_endpoint = var.remote_bootstrap_endpoint
    credentials {
      key    = confluent_api_key.remote.id
      secret = confluent_api_key.remote.secret
    }
  }

  lifecycle {
    prevent_destroy = true
  }

  depends_on = [
    confluent_api_key.local,
    confluent_api_key.remote
  ]
}
