locals {
  app_config = yamldecode(file(var.app_resources_path))

  client_quota      = local.app_config.client_quota
  quota_name        = local.client_quota.name
  quota_description = try(local.client_quota.description, "")
  principal         = local.client_quota.principal
  ingress_byte_rate = local.client_quota.ingress_byte_rate
  egress_byte_rate  = local.client_quota.egress_byte_rate
}

data "confluent_environment" "environment" {
  display_name = var.environment_name
}

data "confluent_kafka_cluster" "cluster" {
  display_name = var.cc_kafka_cluster_name
  environment {
    id = data.confluent_environment.environment.id
  }
}

data "confluent_identity_provider" "identity_provider" {
  display_name = split(":", local.principal)[0]
}

data "confluent_identity_pool" "identity_pool" {
  display_name = split(":", local.principal)[1]
  identity_provider {
    id = data.confluent_identity_provider.identity_provider.id
  }
}

resource "confluent_kafka_client_quota" "client_quota" {
  display_name = local.quota_name
  description  = local.quota_description
  throughput {
    ingress_byte_rate = local.ingress_byte_rate
    egress_byte_rate  = local.egress_byte_rate
  }
  principals = [data.confluent_identity_pool.identity_pool.id]

  kafka_cluster {
    id = data.confluent_kafka_cluster.cluster.id
  }
  environment {
    id = data.confluent_environment.environment.id
  }

  # lifecycle {
  #   prevent_destroy = true
  # }
}