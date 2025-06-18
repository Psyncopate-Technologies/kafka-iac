variable "module_repo_version_tag" {
  type = string
  description = "Repo version tag of module, such as 'v1.0.0'"
}

variable "confluent_cloud_environment_name" {
  type        = string
  description = "Confluent Cloud environment name for the environment that the cluster belongs to"

  validation {
    condition     = length(regexall("^${lower(substr(var.cloud_provider, 0, 3))}-env-${substr(var.environment_name, 0, 1)}-${var.cloud_region}-([1-9][0-9]|0[1-9])$", var.confluent_cloud_environment_name)) > 0
    error_message = "confluent_cloud_environment_name must follow the CCOE Confluent environment naming convention"
  }
}
variable "confluent_cloud_network_name" {
  type        = string
  description = "Confluent Cloud network name for the network that the cluster uses"

  validation {
    condition     = length(regexall("^${lower(substr(var.cloud_provider, 0, 3))}-net-${substr(var.environment_name, 0, 1)}-${var.cloud_region}-([1-9][0-9]|0[1-9])$", var.confluent_cloud_network_name)) > 0
    error_message = "confluent_cloud_network_name must follow the CCOE Confluent network naming convention"
  }
}

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

variable "cluster_number" {
  type        = number
  description = "Monotonically increasing integer used as a suffix for cluster name, 1 <= cluster_number <= 99"

  validation {
    condition     = var.cluster_number >= 1 && var.cluster_number <= 99
    error_message = "cluster_number must be between 1 and 99"
  }

  validation {
    condition     = floor(var.cluster_number) == var.cluster_number
    error_message = "cluster_number must be integer"
  }
}
variable "cluster_multi_zone_available" {
  type        = bool
  description = "The availability zone configuration of the Kafka cluster"
}

variable "cluster_ckus" {
  type        = number
  description = "The number of Confluent Kafka Units (CKUs) to allocate to the cluster for cluster scale"

  validation {
    condition     = var.cluster_multi_zone_available ? var.cluster_ckus >= 2 : var.cluster_ckus >= 1
    error_message = "cluster_ckus must be greater than 1 for single-zone clusters and greater than 2 for multi-zone clusters"
  }
}