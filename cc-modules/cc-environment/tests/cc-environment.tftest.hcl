# Unit tests for Confluent Cloud Environment module
mock_provider "confluent" {
}

# Default test variables
variables {
  environment_name          = "D"
  stream_governance_package = "ESSENTIALS"
}

# Validate that the environment name is set correctly
run "valid_environment_name_check" {
  command = plan

  variables {
    environment_name = "t"
  }

  assert {
    condition     = contains(["d", "dev", "t", "test", "p", "prod", "np", "nonprod"], lower(var.environment_name))
    error_message = "Environment name must be one of: d, dev, t, test, p, prod, np, nonprod (case-insensitive)."
  }
}

run "valid_env_np" {
  command = plan

  variables {
    environment_name = "np"
  }

  assert {
    condition     = contains(["np", "nonprod", "p", "prod", "t", "test", "d", "dev"], lower(var.environment_name))
    error_message = "Valid environment values: np, nonprod, p, prod, t, test, d, dev"
  }
}

run "valid_env_prod" {
  command = plan

  variables {
    environment_name = "prod"
  }

  assert {
    condition     = contains(["np", "nonprod", "p", "prod", "t", "test", "d", "dev"], lower(var.environment_name))
    error_message = "Valid environment values: np, nonprod, p, prod, t, test, d, dev"
  }
}

run "valid_env_case_insensitive" {
  command = plan

  variables {
    environment_name = "DeV"
  }

  assert {
    condition     = contains(["np", "nonprod", "p", "prod", "t", "test", "d", "dev"], lower(var.environment_name))
    error_message = "Valid environment values: np, nonprod, p, prod, t, test, d, dev"
  }
}

run "invalid_env_value" {
  command = plan

  variables {
    environment_name = "stage"
  }

  expect_failures = [ var.environment_name ]
}

run "invalid_env_length" {
  command = plan

  variables {
    environment_name = "prodd"
  }

  expect_failures = [ var.environment_name ]
}

# Validate that the stream governance package is set correctly
run "stream_governance_package_check" {
  command = plan

  variables {
    environment_name          = "T"
    stream_governance_package = "ADVANCED"
  }

  assert {
    condition     = confluent_environment.this.stream_governance[0].package == "ADVANCED"
    error_message = "Expected Stream Governance Package to be ADVANCED"
  }
}

# Validate failure when environment name is empty
run "invalid_empty_environment_name" {
  command = plan

  variables {
    environment_name = ""
  }

  expect_failures = [ var.environment_name ]
}

# Validate failure when environment name includes invalid characters
run "invalid_environment_name_format" {
  command = plan

  variables {
    environment_name = "@!invalid-name"
  }

  expect_failures = [ var.environment_name ]
}

# Validate that the default stream governance package is ESSENTIALS
run "default_stream_governance" {
  command = plan

  assert {
    condition     = confluent_environment.this.stream_governance[0].package == "ESSENTIALS"
    error_message = "Expected default stream governance package to be 'ESSENTIALS'"
  }
}