mock_provider "confluent" {}

variables {
  confluent_cloud_api_key     = "abc123456789"
  confluent_cloud_api_secret  = "xyz987654321"

  local_cluster_id            = "lkc-validlocal01"
  remote_cluster_id           = "lkc-validremote02"

  local_rest_endpoint         = "https://valid-local-endpoint.confluent.cloud"
  remote_bootstrap_endpoint   = "remote.endpoint.com:9092"

  link_name                   = "GCP.DEV.MAL.TOPIC"
  linker_service_account_name = "poc-cluster-linker"

  local_cluster_rbac_crn      = "crn://confluent.cloud/resource/kafka=lkc-validlocal01"
  local_environment_id        = "env-validlocal01"
  remote_environment_id       = "env-validremote01"
}
# -- cluster id tests --
run "valid_local_cluster_id" {
  command = plan

  variables {
    local_cluster_id = "lkc-abc123"
  }

  assert {
    condition     = can(regex("^lkc-[a-z0-9]+$", var.local_cluster_id))
    error_message = "local_cluster_id must be in the format 'lkc-xxxxxx'"
  }
}

run "invalid_local_cluster_id" {
  command = plan
  variables {
    local_cluster_id = "xyz-123"
  }

  expect_failures = [var.local_cluster_id]
}

# -- environment id tests --
run "valid_local_environment_id" {
  command = plan

  variables {
    local_environment_id = "env-xyz789"
  }

  assert {
    condition     = can(regex("^env-[a-z0-9]+$", var.local_environment_id))
    error_message = "local_environment_id must be in the format 'env-xxxxxx'"
  }
}

run "invalid_local_environment_id" {
  command = plan

  variables {
    local_environment_id = "environment-xyz"
  }

  expect_failures = [var.local_environment_id]
}

# -- rest endpoint tests --
run "valid_local_rest_endpoint" {
  command = plan

  variables {
    local_rest_endpoint = "https://some-host:443"
  }

  assert {
    condition     = can(regex("^https://", var.local_rest_endpoint))
    error_message = "local_rest_endpoint must start with https://"
  }
}

run "invalid_local_rest_endpoint" {
  command = plan

  variables {
    local_rest_endpoint = "http://some-host"
  }

  expect_failures = [var.local_rest_endpoint]
}

# -- bootstrap endpoint tests --
run "valid_remote_bootstrap_endpoint" {
  command = plan

  variables {
    remote_bootstrap_endpoint = "remote.kafka.cloud:9092"
  }

  assert {
    condition     = length(trimspace(var.remote_bootstrap_endpoint)) > 0
    error_message = "remote_bootstrap_endpoint must be a non-empty string"
  }
}

run "empty_remote_bootstrap_endpoint" {
  command = plan

  variables {
    remote_bootstrap_endpoint = ""
  }

  expect_failures = [var.remote_bootstrap_endpoint]
}

# -- link name tests --
run "valid_link_name" {
  command = plan

  variables {
    link_name = "GCP.DEV.MAL.TOPIC"
  }

  assert {
    condition     = can(regex("^[A-Z]+\\.[A-Z]+\\.[A-Z]+\\.[A-Z]+$", var.link_name))
    error_message = "link_name must match format 'CLOUD.ENV.MAL.NAME', e.g., 'GCP.DEV.MAL.TOPIC'"
  }
}

run "invalid_link_name_format" {
  command = plan

  variables {
    link_name = "GCP_DEV_TOPIC"
  }

  expect_failures = [var.link_name]
}

# -- service account name --
run "valid_linker_service_account_name" {
  command = plan

  variables {
    linker_service_account_name = "poc-cluster-linker"
  }

  assert {
    condition     = length(trimspace(var.linker_service_account_name)) > 0
    error_message = "linker_service_account_name must be a non-empty string"
  }
}

run "empty_linker_service_account_name" {
  command = plan

  variables {
    linker_service_account_name = ""
  }

  expect_failures = [var.linker_service_account_name]
}

# -- crn format --
run "valid_local_cluster_rbac_crn" {
  command = plan

  variables {
    local_cluster_rbac_crn = "crn://confluent.cloud/resource/path"
  }

  assert {
    condition     = can(regex("^crn://", var.local_cluster_rbac_crn))
    error_message = "local_cluster_rbac_crn must start with 'crn://'"
  }
}

run "invalid_local_cluster_rbac_crn" {
  command = plan

  variables {
    local_cluster_rbac_crn = "invalid-crn-format"
  }

  expect_failures = [var.local_cluster_rbac_crn]
}
