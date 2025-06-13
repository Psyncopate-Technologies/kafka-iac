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