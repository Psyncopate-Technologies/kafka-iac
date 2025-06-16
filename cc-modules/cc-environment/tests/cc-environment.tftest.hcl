# Unit tests for Confluent Cloud Environment module

mock_provider "confluent" {
  mock_data "confluent_environment" {
    defaults = {
      id = "env-abc123"
      display_name = "dev-team1"
      stream_governance = {
        package = "ESSENTIALS"
      }
    }
  }
}

# Default test variables
variables {
  environment_name          = "dev-team1"
  stream_governance_package = "ESSENTIALS"
}

# Validate that the environment name is set correctly
run "environment_name_check" {
  command = plan

  variables {
    environment_name = "dev-team1"
  }

  assert {
    condition     = confluent_environment.this.display_name == "dev-team1"
    error_message = "Expected environment name to be 'dev-team1'"
  }
}

# Validate that the stream governance package is set correctly
run "stream_governance_package_check" {
  command = plan

  variables {
    environment_name          = "dev-team1"
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

# Validate naming conventions (e.g., only alphanumeric, hyphens, underscores)
run "naming_convention_check" {
  command = plan

  variables {
    environment_name = "team_env-01"
  }

  assert {
    condition     = can(regex("^[a-zA-Z0-9_-]+$", confluent_environment.this.display_name))
    error_message = "Environment name must follow naming convention: alphanumeric, underscores, or hyphens only."
  }
}

