terraform {
  required_version = ">= 1.12.2"

  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.30.0"

      # Declare aliases your module accepts
      configuration_aliases = [confluent.local, confluent.remote]
    }
  }
}

provider "confluent" {
  alias = "local"
}

provider "confluent" {
  alias = "remote"
}