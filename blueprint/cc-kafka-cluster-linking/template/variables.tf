variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key (Org Admin)"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret (Org Admin)"
  type        = string
  sensitive   = true
}

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

variable "local_cloud_api_key" {
  description = "API key for local Confluent Cloud provider"
  type        = string
  sensitive   = true
}

variable "local_cloud_api_secret" {
  description = "API secret for local Confluent Cloud provider"
  type        = string
  sensitive   = true
}

variable "remote_cloud_api_key" {
  description = "API key for remote Confluent Cloud provider"
  type        = string
  sensitive   = true
}

variable "remote_cloud_api_secret" {
  description = "API secret for remote Confluent Cloud provider"
  type        = string
  sensitive   = true
}
