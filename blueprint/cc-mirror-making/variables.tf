variable "module_repo_version_tag" {
  description = "Git tag for the module source"
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

variable "mirror_topics" {
  description = "List of mirror topics to be created"
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
      credentials   = object({
        key    = string
        secret = string
      })
    })
  }))
}
