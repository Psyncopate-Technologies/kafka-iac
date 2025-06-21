variable "cloud_provider" {
  type        = string
  description = "Cloud provider to deploy Kafka cluster to"
  validation {
    condition     = contains(["AWS", "AZURE", "GCP"], upper(var.cloud_provider))
    error_message = "cloud_provider must be one of: AWS, AZURE, or GCP"
  }
}
variable "cloud_region" {
  type        = string
  description = "Cloud region of the cluster in the specified cloud provider"
  validation {
    condition     = length(var.cloud_region) > 0
    error_message = "cloud_region must be a non-empty string"
  }
}
variable "environment_name" {
  type        = string
  description = "Deployment environment of cluster: 'dev', 'test', or 'prod'"
  validation {
    condition     = contains(["dev", "test", "prod"], var.environment_name)
    error_message = "cluster_environment_name must be one of: dev, test, prod"
  }
}
variable "environment_number" {
  type        = number
  description = "Monotonically increasing integer used as a suffix for cluster name, 1 <= environment_number <= 99"
  validation {
    condition     = var.environment_number >= 1 && var.environment_number <= 99
    error_message = "environment_number must be between 1 and 99"
  }
  validation {
    condition     = floor(var.environment_number) == var.environment_number
    error_message = "environment_number must be integer"
  }
}

variable "stream_governance_package" {
  type        = string
  description = "stream governance package"
  default     = "ESSENTIALS"

  validation {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.stream_governance_package))
    error_message = "Must be either 'ESSENTIALS' or 'ADVANCED'."
  }
}

variable "module_repo_version_tag" {
  type        = string
  description = "Version tag of the cc-environment module used in this run"
  default     = "latest"
}
