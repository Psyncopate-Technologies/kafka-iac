variable "link_name" {
  description = "Cluster link name (e.g., GCP.DEV.MAL.TOPIC)"
  type        = string
}

variable "linker_service_account_name" {
  description = "Service account name for cluster linking"
  type        = string
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