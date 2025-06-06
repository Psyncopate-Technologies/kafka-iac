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

variable "kafka_api_key" {
  type        = string
  description = "Kafka API key for authenticating with the Kafka REST API."
  sensitive   = true
}

variable "kafka_api_secret" {
  type        = string
  description = "Kafka API secret for the Kafka REST API."
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

variable "kafka_cluster_name" {
  type        = string
  description = "Kafka Cluster Name. This is used to retrieve the ID of the Kafka Cluster and the rest endpoint that is to be used to create the topic."
  nullable    = false
  validation {
    condition     = length(var.kafka_cluster_name) > 0
    error_message = "kafka_cluster_name must be a valid name"
  }
}

variable "topic_path" {
  type        = string
  description = "Absolute path to the YAML file defining the topic configuration (must be a single-topic YAML)."
  nullable    = false
  validation {
    condition     = can(regex("\\.ya?ml$", var.topic_path))
    error_message = "topic_path must point to a .yaml or .yml file."
  }
}

variable "default_partitions" {
  type    = number
  description = "Default number of partitions for the topic if not specified in the YAML file. The default value here will be overridden from terragrunt based on environment."
  default = 3  # Optional: Terragrunt will override this anyway
}
