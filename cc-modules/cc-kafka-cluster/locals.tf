locals {
  cluster_cloud_prefix = lower(substr(var.cloud_provider, 0, 3))
  cluster_name         = "${local.cluster_cloud_prefix}-clstr-${substr(var.environment_name, 0, 1)}-${var.cloud_region}-${format("%02d", var.cluster_number)}"
}