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

variable "cluster_number" {
  type        = number
  description = "Cluster number suffix"
}

variable "stream_governance_package" {
  type        = string
  description = "Stream Governance package"
  default     = "ESSENTIALS"
}
variable "module_repo_version_tag" {
  type        = string
  description = "Version tag of the cc-environment module used in this run"
}

variable "confluent_cloud_environment_name" {
  description = "The fully constructed Confluent Cloud environment name."
  type        = string
}
