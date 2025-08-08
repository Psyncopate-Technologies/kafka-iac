terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
    }
  }
}

provider "confluent" {
  alias     = "local"
  cloud_api_key    = var.local_cloud_api_key
  cloud_api_secret = var.local_cloud_api_secret
}

provider "confluent" {
  alias     = "remote"
  cloud_api_key    = var.remote_cloud_api_key
  cloud_api_secret = var.remote_cloud_api_secret
}
