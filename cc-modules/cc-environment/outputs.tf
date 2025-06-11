output "environment" {
  description = "The created Confluent Environment resource"
  value       = confluent_environment.this
}

output "stream_governance_package" {
  description = "The created environment stream governance package"
  value       = confluent_stream_governance_package.this
}
