module "cc-cluster-linking" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-cluster-linking?ref=${var.module_repo_version_tag}"

  module_repo_version_tag = var.module_repo_version_tag

  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret

  link_name                  = var.link_name

  local_environment_id       = var.local_environment_id
  local_cluster_id           = var.local_cluster_id
  local_rest_endpoint        = var.local_rest_endpoint
  local_cluster_rbac_crn     = var.local_cluster_rbac_crn

  remote_environment_id      = var.remote_environment_id
  remote_cluster_id          = var.remote_cluster_id
  remote_bootstrap_endpoint  = var.remote_bootstrap_endpoint
}
