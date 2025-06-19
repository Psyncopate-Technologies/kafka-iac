locals {
  confluent_cloud_environment_name = lower("${var.cloud_provider}-env-${substr(var.environment_name, 0, 1)}-${var.cloud_region}-${format("%02d", var.cluster_number)}")
}