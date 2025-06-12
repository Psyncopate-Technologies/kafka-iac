terraform {
  #required_version = ">= 1.9.8"
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.30.0"
    }
  }
}

resource "confluent_environment" "this" {
  display_name = var.environment_name

  stream_governance {
    package = var.stream_governance_package
  }

  lifecycle {
    prevent_destroy = true
  }
}
