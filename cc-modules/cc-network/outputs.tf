# Outputs: confluent_network resource
output "confluent_network_id" {
  description = "The ID of the created Confluent Cloud Network."
  value       = confluent_network.private-link.id
}

output "confluent_network_resource_name" {
  description = "The Confluent Resource Name of the Network."
  value       = confluent_network.private-link.resource_name
}

# Outputs: confluent_private_link_access resource
output "private_link_access_id" {
  description = "The ID of the Confluent Cloud Private Link Access."
  value       = confluent_private_link_access.azure.id
}
