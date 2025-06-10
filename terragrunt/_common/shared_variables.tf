variable "confluent_api_key" {
  type        = string
  description = "API key for authenticating with the Confluent Cloud control plane (for provider block)."
  sensitive   = true
}

variable "confluent_api_secret" {
  type        = string
  description = "API secret for the Confluent Cloud control plane (for provider block)."
  sensitive   = true
}

variable "cc_kafka_api_key" {
  type        = string
  description = "Kafka API key for authenticating with the Kafka REST API."
  sensitive   = true
}

variable "cc_kafka_api_secret" {
  type        = string
  description = "Kafka API secret for the Kafka REST API."
  sensitive   = true
}

variable "cc_sr_api_key" {
  type        = string
  description = "Schema Registry API key for authenticating with the SR REST API."
  sensitive   = true
}

variable "cc_sr_api_secret" {
  type        = string
  description = "Schema Registry API secret for the SR REST API."
  sensitive   = true
}

variable "environment_name" {
  type        = string
  description = "The Confluent Cloud Environment Name. This is used to retrieve the ID of the Environment that is to be used to determine the Kafka Cluster ID"
  nullable    = false
  validation {
    condition     = length(var.environment_name) > 0
    error_message = "environment_name cannot be an empty string."
  }
}

variable "cc_kafka_cluster_name" {
  type        = string
  description = "Kafka Cluster Name. This is used to retrieve the ID of the Kafka Cluster and the rest endpoint that is to be used to create the topic."
  nullable    = false
  validation {
    condition     = length(var.cc_kafka_cluster_name) > 0
    error_message = "cc_kafka_cluster_name must be a valid name"
  }
}