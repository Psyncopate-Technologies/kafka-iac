mock_provider "confluent" {
  mock_data "confluent_environment" {
    defaults = {
      id           = "env-local-123"
      display_name = "local-env"
    }
  }

  mock_data "confluent_kafka_cluster" {
    defaults = {
      id                 = "lkc-local-123"
      display_name       = "local-cluster"
      rest_endpoint      = "https://rest.local.kafka.mock"
      bootstrap_endpoint = "SASL_SSL://local.kafka.mock:9092"
      rbac_crn           = "crn://confluent.cloud/kafka=lkc-local-123"
      environment        = [{
        id = "env-local-123"
      }]
    }
  }
}

variables {
  link_name                = "GCP.DEV.MAL.TOPIC"
  local_environment_name   = "local-env"
  remote_environment_name  = "local-env"           # Using same env for test
  local_kafka_cluster_name = "local-cluster"
  remote_kafka_cluster_name= "local-cluster"       # Using same cluster for test
}

run "test_outputs" {
  command = plan

  assert {
    condition     = local.linker_sa_name == "GCP.DEV.MAL.TOPIC-linker"
    error_message = "Linker service account name does not match expected"
  }

  assert {
    condition     = length(local.local_rest_endpoint) > 0
    error_message = "Local rest endpoint should not be empty"
  }

  assert {
    condition     = substr(local.local_cluster_rbac_crn, 0, 6) == "crn://"
    error_message = "local_cluster_rbac_crn does not start with 'crn://'"
  }
}

run "test_non_empty_env_names" {
  command = plan

  assert {
    condition     = length(var.local_environment_name) > 0
    error_message = "local_environment_name must not be empty"
  }

  assert {
    condition     = length(var.remote_environment_name) > 0
    error_message = "remote_environment_name must not be empty"
  }
}

run "test_endpoints_format" {
  command = plan

  assert {
    condition     = can(regex("^https?://", local.local_rest_endpoint))
    error_message = "local_rest_endpoint should start with http:// or https://"
  }

  assert {
    condition     = can(regex("^SASL_SSL://", local.remote_bootstrap_endpoint))
    error_message = "remote_bootstrap_endpoint should start with SASL_SSL://"
  }
}

