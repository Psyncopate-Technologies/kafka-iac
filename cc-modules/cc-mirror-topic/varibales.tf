variable "confluent_cloud_api_key" {
  type        = string
  description = "Confluent Cloud API Key"
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  type        = string
  description = "Confluent Cloud API Secret"
  sensitive   = true
}

variable "target_kafka_cluster_id" {
  type        = string
  description = "ID of the target Kafka cluster where mirror topics will be created"
}

variable "mirror_topics" {
  type = list(object({
    mirror_topic_name = string

    source_kafka_topic = object({
      topic_name = string
    })

    cluster_link = object({
      link_name = string
    })

    kafka_cluster = object({
      id            = string
      rest_endpoint = string
      credentials = object({
        key    = string
        secret = string
      })
    })

    prevent_destroy = optional(bool)
  }))

  description = "List of mirror topics with full config blocks"
}
