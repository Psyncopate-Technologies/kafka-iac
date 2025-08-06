variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (Org Admin)"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.confluent_cloud_api_key) > 0
    error_message = "The Confluent Cloud API Key must not be empty."
  }
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret (Org Admin)"
  type        = string
  sensitive   = true

  validation {
    condition     = length(var.confluent_cloud_api_secret) > 0
    error_message = "The Confluent Cloud API Secret must not be empty."
  }
}

variable "link_name" {
  description = "Cluster link name (e.g., GCP.DEV.MAL.TOPIC)"
  type        = string
  default     = "GCP.DEV.MAL.TOPIC"

  validation {
    condition = contains(
      ["GCP.DEV.MAL.TOPIC", "AWS.DEV.MAL.TOPIC", "AZU.DEV.MAL.TOPIC", "DDC.DEV.MAL.TOPIC"],
      var.link_name
    )
    error_message = "link_name must be one of: GCP.DEV.MAL.TOPIC, AWS.DEV.MAL.TOPIC, AZU.DEV.MAL.TOPIC, DDC.DEV.MAL.TOPIC"
  }
}

variable "linker_service_account_name" {
  description = "Service account name for cluster linking"
  type        = string
  default     = "poc-cluster-linker"

  validation {
    condition     = length(var.linker_service_account_name) > 0
    error_message = "The linker_service_account_name must not be empty."
  }
}

variable "local_environment_name" {
  type        = string
  description = "Display name of the local environment"
}

variable "remote_environment_name" {
  type        = string
  description = "Display name of the remote environment"
}

variable "local_kafka_cluster_name" {
  type        = string
  description = "Display name of the local Kafka cluster"
}

variable "remote_kafka_cluster_name" {
  type        = string
  description = "Display name of the remote Kafka cluster"
}