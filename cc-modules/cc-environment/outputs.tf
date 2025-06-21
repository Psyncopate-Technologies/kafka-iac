output "environment_id" {
  description = "The created Confluent Environment resource"
  value       = confluent_environment.this.id
}

output "stream_governance_package" {
  description = "The stream governance package used in the environment"
  value       = var.stream_governance_package
}

output "confluent_cloud_environment_name" {
  value       = local.confluent_cloud_environment_name
  description = "Constructed environment name following CCOE naming convention."
}

output "module_repo_version_tag" {
  value       = var.module_repo_version_tag
  description = "Version tag of the cc-environment module used in this run"
}