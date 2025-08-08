terraform {
  required_version = ">= 1.12.2"

  required_providers {
    confluent.local = {
      source  = "confluentinc/confluent"
      version = "2.30.0"
    }
    confluent.remote = {
      source  = "confluentinc/confluent"
      version = "2.30.0"
    }
  }
}
