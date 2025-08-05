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

variable "mirror_topics_yaml_file" {
  type        = string
  description = "Path to the YAML file containing mirror topic specifications"
}
variable "mirror_topic_config_raw" {
  type        = string
  description = "Raw YAML string defining mirror topic configuration."
}

