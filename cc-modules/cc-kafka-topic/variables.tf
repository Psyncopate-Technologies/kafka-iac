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

variable "topic_path" {
  type        = string
  description = "Absolute path to the YAML file defining the topic configuration (must be a single-topic YAML)."
  nullable    = false
  validation {
    condition     = can(regex("\\.ya?ml$", var.topic_path))
    error_message = "topic_path must point to a .yaml or .yml file."
  }
}

variable "topic_name" {
  type        = string
  description = "The name of the topic to be created. This is used to validate the naming convention of the topic."
  nullable    = false
  validation {
    condition = length(var.topic_name) > 0 && can(
      regex(
        "^[A-Z]{3}\\.(DEV[1-4]|TEST[1-4]|PROD)\\.[A-Z0-9]{2,}\\.[A-Za-z0-9]+\\.[A-Za-z0-9]+\\.(JSON|AVRO|STRING)\\.(CDO\\.EVENT|SPECIFIC\\.EVENT|RAW\\.EVENT|COMMAND|API\\.REQUEST|API\\.RESPONSE|STREAM\\.REQUEST|STREAM\\.RESPONSE|PRIVATE|DEADLETTER)$",
        var.topic_name
      )
    )
    error_message = "The topic_name must follow the format:DataCenter.Environment.MAL.EnterpriseTaxonomy.CapabilityTaxonomy.Format.MessagePattern : Example: GCP.DEV1.CLMAL1.CustomerData.Consent.JSON.CDO.EVENT"
  }
}

variable "default_partitions" {
  type    = number
  description = "Default number of partitions for the topic if not specified in the YAML file. The default value here will be overridden from terragrunt based on environment."
  default = 3  # Optional: Terragrunt will override this anyway
}
