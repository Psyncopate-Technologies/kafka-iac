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

variable "environment_id" {
  description = "Confluent Cloud Environment ID"
  type        = string
}

variable "local_cluster_id" {
  description = "Kafka cluster ID (local)"
  type        = string
}

variable "remote_cluster_id" {
  description = "Kafka cluster ID (remote)"
  type        = string
}

variable "local_rest_endpoint" {
  description = "REST endpoint for local Kafka cluster"
  type        = string
}

variable "remote_bootstrap_endpoint" {
  description = "Bootstrap endpoint for remote Kafka cluster"
  type        = string
}

variable "link_name" {
  description = "Cluster link name"
  type        = string
  default     = "poc-bidirectional-link"
}

variable "linker_service_account_name" {
  description = "Service account name for cluster linking"
  type        = string
  default     = "poc-cluster-linker"
}

variable "local_cluster_rbac_crn" {
  description = "CRN pattern for the local Kafka cluster for RBAC role binding"
  type        = string
}
