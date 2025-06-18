output "module_repo_version_tag" {
  value = var.module_repo_version_tag
}

output "cluster_id" {
  value       = confluent_kafka_cluster.this.id
  description = "The ID of the Kafka cluster (e.g. 'lkc-abc123')"
}

output "cluster_bootstrap_endpoint" {
  value       = confluent_kafka_cluster.this.bootstrap_endpoint
  description = "The bootstrap endpoint used by Kafka clients to connect to the Kafka cluster"
}
output "cluster_rest_endpoint" {
  value       = confluent_kafka_cluster.this.rest_endpoint
  description = "The REST endpoint of the Kafka cluster"
}

output "cluster_availability_zones" {
  value       = confluent_kafka_cluster.this.dedicated[0].zones
  description = "The list of cloud provider zones the cluster is in"
}

output "schema_registry_id" {
  value = data.confluent_schema_registry_cluster.cc_schema_registry.id
}
output "schema_registry_rest_endpoint" {
  value = data.confluent_schema_registry_cluster.cc_schema_registry.rest_endpoint
}