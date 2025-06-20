# Outputs: cc_network module
output "confluent_network_id" {
  description = "The ID of the created Confluent Cloud Network."
  value       = module.cc_network.confluent_network_id
}

output "confluent_network_name" {
  description = "The name of Confluent Cloud Network."
  value       = module.cc_network.confluent_network_name
}

output "confluent_network_resource_name" {
  description = "The Resource Name of the Confluent Cloud Network."
  value       = module.cc_network.confluent_network_resource_name
}

output "confluent_network_dns_domain" {
  description = "The DNS Domain of Confluent Cloud Network."
  value       = module.cc_network.confluent_network_dns_domain
}

output "confluent_network_zone_info" {
  description = "The Zone Info of Confluent Cloud Network."
  value       = module.cc_network.confluent_network_zone_info
}

output "confluent_network_azure_info" {
  description = "The AZURE info of Confluent Cloud Network."
  value       = module.cc_network.confluent_network_azure_info
}

output "confluent_network_aws_info" {
  description = "The AWS info of Confluent Cloud Network."
  value       = module.cc_network.confluent_network_aws_info
}

output "confluent_network_gcp_info" {
  description = "The GCP info of Confluent Cloud Network."
  value       = module.cc_network.confluent_network_gcp_info
}

# Outputs: confluent_private_link_access resource
output "private_link_access_id" {
  description = "The ID of the Confluent Cloud Private Link Access."
  value       = module.cc_network.private_link_access_id
}

output "private_link_access_name" {
  description = "The name of the Confluent Cloud Private Link Access."
  value       = module.cc_network.private_link_access_name
}
