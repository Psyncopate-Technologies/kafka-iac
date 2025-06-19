mock_provider "confluent" {}

# Default variables for all runs
variables {
  cloud_provider                     = "AWS"
  cloud_region                       = "us-west-1"
  environment_name                   = "dev"
  cluster_number                     = 1
  stream_governance_package          = "ESSENTIALS"
  module_repo_version_tag            = "latest"
  confluent_cloud_environment_name   = "aws-env-dev-us-west-1-01"
}

run "valid_cloud_provider_aws" {
  command = plan
   variables {
    cloud_provider = "AWS"
  }

  assert {
    condition     = contains(["AWS", "AZURE", "GCP"], upper(var.cloud_provider))
    error_message = "cloud_provider must be one of: AWS, AZURE, or GCP"
  }
}

run "valid_cloud_provider_gcp" {
  command = plan
   variables {
    cloud_provider = "GCP"
  }

  assert {
    condition     = contains(["AWS", "AZURE", "GCP"], upper(var.cloud_provider))
    error_message = "cloud_provider must be one of: AWS, AZURE, or GCP"
  }
}

run "invalid_cloud_provider" {
  command = plan
   variables {
    cloud_provider = "IBM"
  }
  expect_failures = [var.cloud_provider]
}

run "empty_cloud_provider" {
  command = plan
   variables {
    cloud_provider = ""
  }
  expect_failures = [var.cloud_provider]
}

run "valid_cloud_region" {
  command = plan
   variables {
    cloud_region = "eastus2"
  }

  assert {
    condition     = length(var.cloud_region) > 0
    error_message = "cloud_region must be a non-empty string"
  }
}

run "empty_cloud_region" {
  command = plan
   variables {
    cloud_region = ""
  }
  expect_failures = [var.cloud_region]
}

run "valid_environment_name_dev" {
  command = plan
   variables {
    environment_name = "dev"
  }

  assert {
    condition     = contains(["dev", "test", "prod"], var.environment_name)
    error_message = "environment_name must be one of: dev, test, prod"
  }
}

run "valid_environment_name_test" {
  command = plan
   variables {
    environment_name = "test"
  }

  assert {
    condition     = contains(["dev", "test", "prod"], var.environment_name)
    error_message = "environment_name must be one of: dev, test, prod"
  }
}

run "invalid_environment_name" {
  command = plan
   variables {
    environment_name = "stage"
  }
  expect_failures = [var.environment_name]
}

run "empty_environment_name" {
  command = plan
   variables {
    environment_name = ""
  }
  expect_failures = [var.environment_name]
}

run "valid_cluster_number" {
  command = plan
   variables {
    cluster_number = 5
  }

  assert {
    condition     = var.cluster_number >= 1 && var.cluster_number <= 99
    error_message = "cluster_number must be between 1 and 99"
  }
}

run "invalid_cluster_number_zero" {
  command = plan
   variables {
    cluster_number = 0
  }
  expect_failures = [var.cluster_number]
}

run "invalid_cluster_number_overflow" {
  command = plan
   variables {
    cluster_number = 100
  }
  expect_failures = [var.cluster_number]
}

run "invalid_cluster_number_float" {
  command = plan
   variables {
    cluster_number = 4.5
  }
  expect_failures = [var.cluster_number]
}

run "valid_stream_governance_essentials" {
  command = plan
   variables {
    stream_governance_package = "ESSENTIALS"
  }

  assert {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.stream_governance_package))
    error_message = "Must be either 'ESSENTIALS' or 'ADVANCED'"
  }
}

run "valid_stream_governance_advanced" {
  command = plan
   variables {
    stream_governance_package = "ADVANCED"
  }

  assert {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.stream_governance_package))
    error_message = "Must be either 'ESSENTIALS' or 'ADVANCED'"
  }
}

run "invalid_stream_governance_package" {
  command = plan
   variables {
    stream_governance_package = "PREMIUM"
  }
  expect_failures = [var.stream_governance_package]
}

run "default_module_repo_version_tag" {
  command = plan

  assert {
    condition     = var.module_repo_version_tag == "latest"
    error_message = "module_repo_version_tag should default to 'latest'"
  }
}

run "custom_module_repo_version_tag" {
  command = plan
   variables {
    module_repo_version_tag = "v1.0.2"
  }

  assert {
    condition     = var.module_repo_version_tag == "v1.0.2"
    error_message = "module_repo_version_tag should be 'v1.0.2'"
  }
}
