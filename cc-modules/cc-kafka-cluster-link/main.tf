# Create service account for cluster linking
resource "confluent_service_account" "linker" {
  provider     = confluent.local
  display_name = local.linker_sa_name
  description  = "SA for Cluster Linking"
}

# Role Binding: Needed to allow cluster link creation (CloudClusterAdmin minimum for cluster scope)
resource "confluent_role_binding" "linker_binding" {
  provider    = confluent.local
  principal   = "User:${confluent_service_account.linker.id}"
  role_name   = "CloudClusterAdmin"
  crn_pattern = local.local_cluster_rbac_crn
}

# API key for local cluster
resource "confluent_api_key" "local" {
  provider     = confluent.local
  display_name = local.local_api_key_name
  description  = "API Key for local cluster access"

  owner {
    id          = confluent_service_account.linker.id
    api_version = "iam/v2"
    kind        = "ServiceAccount"
  }

  managed_resource {
    id          = local.local_cluster_id
    api_version = "cmk/v2"
    kind        = "Cluster"
    environment {
      id = local.local_environment_id
    }
  }

  depends_on = [confluent_role_binding.linker_binding]
}

# API key for remote cluster
resource "confluent_api_key" "remote" {
  provider     = confluent.remote
  display_name = local.remote_api_key_name
  description  = "API Key for remote cluster access"

  owner {
    id          = confluent_service_account.linker.id
    api_version = "iam/v2"
    kind        = "ServiceAccount"
  }

  managed_resource {
    id          = local.remote_cluster_id
    api_version = "cmk/v2"
    kind        = "Cluster"
    environment {
      id = local.remote_environment_id
    }
  }

  depends_on = [confluent_role_binding.linker_binding]
}

# Cluster Link
resource "confluent_cluster_link" "this" {
  provider  = confluent.local
  link_name = var.link_name
  link_mode = "BIDIRECTIONAL"

  local_kafka_cluster {
    id            = local.local_cluster_id
    rest_endpoint = local.local_rest_endpoint
    credentials {
      key    = confluent_api_key.local.id
      secret = confluent_api_key.local.secret
    }
  }

  remote_kafka_cluster {
    id                 = local.remote_cluster_id
    bootstrap_endpoint = local.remote_bootstrap_endpoint
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
