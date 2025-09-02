variable "replications" {
  type = map(object({
    mirror_topic_status = string
    mirror_topic_name   = string
    cluster_link_name   = string
    target_cluster_name = string
    target_env_name     = string
  }))
  description = "Map of mirror topics to create, keyed by provider-region"
}

variable "source_topic_name" {
  type        = string
  description = "Source Kafka topic name"
}

variable "target_cluster_api_key" {
  description = "API Key for target Kafka cluster"
  type        = string
  sensitive   = true
}

variable "target_cluster_api_secret" {
  description = "API Secret for target Kafka cluster"
  type        = string
  sensitive   = true
}
