variable "env_config_path" {
  description = "Path to the YAML config for both environment and schema registry"
  type        = string
}

variable "kafka_api_key" {
  description = "Kafka API key"
  type        = string
  sensitive   = true
}

variable "kafka_api_secret" {
  description = "Kafka API secret"
  type        = string
  sensitive   = true
}

variable "kafka_rest_endpoint" {
  description = "Kafka REST endpoint"
  type        = string
}
