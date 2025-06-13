terraform {
  required_version = ">= 1.9.8"

  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.30.0"
    }
  }
}
