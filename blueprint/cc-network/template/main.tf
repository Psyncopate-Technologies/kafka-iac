module "cc_network" {
  # source = "/Users/psyncopate-admin/Library/CloudStorage/OneDrive-Psyncopate,Inc/Workspace/Clients/Lumen/Devlopment/Psyncopate-Technologies/kafka-iac/cc-modules/cc-network"
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-network?ref=${local.module_repo_version_tag}"
  confluent_cloud_api_key = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  network_display_name = var.network_display_name
  region = var.region
  private_link_dns_resolution = var.private_link_dns_resolution
  private_link_access_display_name = var.private_link_access_display_name
  customer_azure_subscription_id = var.customer_azure_subscription_id
  confluent_cloud_environment_name = var.confluent_cloud_environment_name
}
