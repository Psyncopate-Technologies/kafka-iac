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

variable "local_cluster_id" {
  description = "Kafka cluster ID (local)"
  type        = string

  validation {
    condition     = can(regex("^lkc-[a-z0-9]+$", var.local_cluster_id))
    error_message = "The local_cluster_id must start with 'lkc-' followed by alphanumeric characters."
  }
}

variable "remote_cluster_id" {
  description = "Kafka cluster ID (remote)"
  type        = string

  validation {
    condition     = can(regex("^lkc-[a-z0-9]+$", var.remote_cluster_id))
    error_message = "The remote_cluster_id must start with 'lkc-' followed by alphanumeric characters."
  }
}

variable "local_rest_endpoint" {
  description = "REST endpoint for local Kafka cluster"
  type        = string

  validation {
    condition     = can(regex("^https://", var.local_rest_endpoint))
    error_message = "The local_rest_endpoint must be a valid HTTPS URL."
  }
}

variable "remote_bootstrap_endpoint" {
  description = "Bootstrap endpoint for remote Kafka cluster"
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]+:[0-9]+$", var.remote_bootstrap_endpoint))
    error_message = "The remote_bootstrap_endpoint must be in host:port format."
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

variable "local_cluster_rbac_crn" {
  description = "CRN pattern for the local Kafka cluster for RBAC role binding"
  type        = string

  validation {
    condition     = can(regex("^crn:.*$", var.local_cluster_rbac_crn))
    error_message = "The local_cluster_rbac_crn must be a valid CRN string starting with 'crn:'."
  }
}

variable "local_environment_id" {
  description = "Environment ID of the local Kafka cluster"
  type        = string
  validation {
    condition     = can(regex("^env-[a-zA-Z0-9]+$", var.local_environment_id))
    error_message = "The local_environment_id must be in format 'env-<alphanumeric>' (e.g., env-abcd1)."
  }
}

variable "remote_environment_id" {
  description = "Environment ID of the remote Kafka cluster"
  type        = string
  validation {
    condition     = can(regex("^env-[a-zA-Z0-9]+$", var.remote_environment_id))
    error_message = "The remote_environment_id must be in format 'env-<alphanumeric>' (e.g., env-abcd1)."
  }
}
