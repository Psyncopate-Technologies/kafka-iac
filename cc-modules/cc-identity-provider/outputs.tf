output "identity_provider_id" {
  value       = confluent_identity_provider.this.id
  description = "The ID of the created Confluent Identity Provider"
}

output "identity_provider_name" {
  value       = confluent_identity_provider.this.display_name
  description = "The display name of the Confluent Identity Provider"
}

output "module_repo_version_tag" {
  value       = local.module_repo_version_tag
  description = "Version tag of the cc-identity_provider module used in this run"
}