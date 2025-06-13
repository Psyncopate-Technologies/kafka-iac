variable "environment_name" {
  type        = string
  description = "Name of the Confluent Cloud environment"
}

variable "stream_governance_package" {
  type        = string
  description = "stream governance package"
  default     = "ESSENTIALS"
}

