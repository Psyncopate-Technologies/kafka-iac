variable "replications" {
  type = map(object({
    target_provider     = string
    target_kafka_cluster_region = string
    mirror_topic_status = string
    mirror_topic_name   = string
    cluster_link_name   = string
    target_cluster_name = string
    target_env_name     = string
    target_cluster_api_key = string
    target_cluster_api_secret = string
  }))
  description = "Map of mirror topics to create, keyed by provider-region"
  default = {}
}

variable "source_topic_name" {
  type        = string
  description = "Source Kafka topic name"
}