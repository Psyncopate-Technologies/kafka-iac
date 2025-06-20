variable "cloud_provider" {
  type        = string
  description = "Cloud provider acronym (e.g., azu, aws, gcp)"
}

variable "environment_name" {
  type        = string
  description = "Environment name (e.g., dev, test, prod)"
}

variable "cloud_region" {
  type        = string
  description = "Cloud region (e.g., eastus2, us-west-1)"
}

variable "environment_number" {
  type        = number
  description = "Cluster number suffix"
}

variable "stream_governance_package" {
  type        = string
  description = "Stream Governance package"
  default     = "ESSENTIALS"
}