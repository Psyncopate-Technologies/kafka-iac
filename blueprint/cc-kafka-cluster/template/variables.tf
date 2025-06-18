variable "module_repo_version_tag" {
  type = string
  description = "Repo version tag of module, such as 'v1.0.0'"
}

variable "confluent_cloud_environment_name" {
  type        = string
  description = "Confluent Cloud environment name for the environment that the cluster belongs to"
}
variable "confluent_cloud_network_name" {
  type        = string
  description = "Confluent Cloud network name for the network that the cluster uses"
}

variable "cloud_provider" {
  type        = string
  description = "Cloud provider to deploy Kafka cluster to"
}
variable "cloud_region" {
  type        = string
  description = "Cloud region of the cluster in the specified cloud provider"
}

variable "environment_name" {
  type        = string
  description = "Deployment environment of cluster: 'dev', 'test', or 'prod'"
}

variable "cluster_number" {
  type        = number
  description = "Monotonically increasing integer used as a suffix for cluster name, 1 <= cluster_number <= 99"
}
variable "cluster_multi_zone_available" {
  type        = bool
  description = "The availability zone configuration of the Kafka cluster"
}

variable "cluster_ckus" {
  type        = number
  description = "The number of Confluent Kafka Units (CKUs) to allocate to the cluster for cluster scale"
}