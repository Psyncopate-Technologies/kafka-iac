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
}

