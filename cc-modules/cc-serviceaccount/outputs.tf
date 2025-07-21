output "cluster_link_name" {
  value = confluent_cluster_link.this.link_name
}

output "local_api_key_id" {
  value = confluent_api_key.local.id
}

output "remote_api_key_id" {
  value = confluent_api_key.remote.id
}

output "service_account_id" {
  value = confluent_service_account.linker.id
}
