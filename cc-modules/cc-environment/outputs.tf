output "environment" {
  description = "The created Confluent Environment resource"
  value       = confluent_environment.this
}

output "schema_registry_cluster" {
  description = "The created Schema Registry Cluster resource"
  value       = confluent_schema_registry_cluster.this
}
