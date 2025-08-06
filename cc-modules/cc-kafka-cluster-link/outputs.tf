output "service_account_id" {
  description = "ID of the service account created for cluster linking"
  value       = confluent_service_account.linker.id
}

output "service_account_name" {
  description = "Display name of the service account"
  value       = confluent_service_account.linker.display_name
}

output "local_api_key_id" {
  description = "API key ID for local cluster"
  value       = confluent_api_key.local.id
}

output "remote_api_key_id" {
  description = "API key ID for remote cluster"
  value       = confluent_api_key.remote.id
}

output "cluster_link_name" {
  description = "Name of the cluster link"
  value       = confluent_cluster_link.this.link_name
}

output "cluster_link_id" {
  description = "ID of the cluster link"
  value       = confluent_cluster_link.this.id
}

output "local_cluster_id" {
  description = "Local Kafka cluster ID used in the cluster link"
  value       = var.local_cluster_id
}

output "remote_cluster_id" {
  description = "Remote Kafka cluster ID used in the cluster link"
  value       = var.remote_cluster_id
}
