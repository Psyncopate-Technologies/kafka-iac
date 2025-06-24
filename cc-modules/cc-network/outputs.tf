# Outputs: confluent_network resource
output "confluent_network_id" {
  description = "The ID of the created Confluent Cloud Network."
  value       = confluent_network.private_link_network.id
}

output "confluent_network_name" {
  description = "The name of Confluent Cloud Network."
  value       = confluent_network.private_link_network.display_name
}

output "confluent_network_resource_name" {
  description = "The Resource Name of the Confluent Cloud Network."
  value       = confluent_network.private_link_network.resource_name
}

output "confluent_network_dns_domain" {
  description = "The DNS Domain of Confluent Cloud Network."
  value       = confluent_network.private_link_network.dns_domain
}

output "confluent_network_zone_info" {
  description = "The Zone Info of Confluent Cloud Network."
  value       = confluent_network.private_link_network.zone_info
}

output "confluent_network_azure_info" {
  description = "The AZURE info of Confluent Cloud Network."
  value       = confluent_network.private_link_network.azure
}

output "confluent_network_aws_info" {
  description = "The AWS info of Confluent Cloud Network."
  value       = confluent_network.private_link_network.aws
}

output "confluent_network_gcp_info" {
  description = "The GCP info of Confluent Cloud Network."
  value       = confluent_network.private_link_network.gcp
}

# Outputs: confluent_private_link_access resource
output "private_link_access_id" {
  description = "The ID of the Confluent Cloud Private Link Access."
  value       = confluent_private_link_access.private_link_access.id
}

output "private_link_access_name" {
  description = "The name of the Confluent Cloud Private Link Access."
  value       = confluent_private_link_access.private_link_access.display_name
}

# Outputs: variables
output "module_repo_version_tag" {
  value = var.module_repo_version_tag
}