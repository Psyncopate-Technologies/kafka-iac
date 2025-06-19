output "environment_id" {
  description = "The created Confluent Environment resource"
  value       = confluent_environment.this.id
}

output "stream_governance_package" {
  description = "The stream governance package used in the environment"
  value       = var.stream_governance_package
}

output "environment_display_name" {
  value = confluent_environment.this.display_name
  description = "The created Confluent Environment name"
}

output "module_repo_version_tag" {
  value       = local.module_repo_version_tag
  description = "Version tag of the cc-environment module used in this run"
}