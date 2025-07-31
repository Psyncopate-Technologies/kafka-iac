variable "module_repo_version_tag" {
  description = "The version tag of the module to use"
  type        = string
}

variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API key"
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API secret"
  type        = string
  sensitive   = true
}

variable "link_name" {
  description = "Cluster link name"
  type        = string
}

variable "local_environment_id" {
  description = "ID of the environment that contains the local cluster"
  type        = string
}

variable "local_cluster_id" {
  description = "Kafka cluster ID for the local cluster"
  type        = string
}

variable "local_rest_endpoint" {
  description = "REST endpoint for the local Kafka cluster"
  type        = string
}

variable "local_cluster_rbac_crn" {
  description = "CRN for RBAC scope on the local cluster"
  type        = string
}

variable "remote_environment_id" {
  description = "ID of the environment that contains the remote cluster"
  type        = string
}

variable "remote_cluster_id" {
  description = "Kafka cluster ID for the remote cluster"
  type        = string
}

variable "remote_bootstrap_endpoint" {
  description = "Kafka bootstrap endpoint for the remote cluster"
  type        = string
}
