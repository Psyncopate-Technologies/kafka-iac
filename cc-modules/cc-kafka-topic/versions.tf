terraform {
  required_version = "1.12.2"
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.30.0"
    }
  }
}