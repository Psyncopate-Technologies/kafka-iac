output "mirror_topic_names" {
  description = "Names of the mirror topics created"
  value       = { for k, mt in confluent_kafka_mirror_topic.this : k => mt.mirror_topic_name }
}

output "source_topic_name" {
  description = "Name of the source Kafka topic"
  value       = var.source_topic_name
}

output "cluster_link_names" {
  description = "Cluster link names used for each mirror topic"
  value       = { for k, mt in confluent_kafka_mirror_topic.this : k => mt.cluster_link[0].link_name }
}

output "kafka_cluster_ids" {
  description = "IDs of Kafka clusters where mirror topics are created"
  value       = { for k, mt in confluent_kafka_mirror_topic.this : k => mt.kafka_cluster[0].id }
}

output "kafka_cluster_rest_endpoints" {
  description = "REST endpoints of Kafka clusters"
  value       = { for k, mt in confluent_kafka_mirror_topic.this : k => mt.kafka_cluster[0].rest_endpoint }
}

output "mirror_topic_statuses" {
  description = "Statuses of the mirror topics"
  value       = { for k, mt in confluent_kafka_mirror_topic.this : k => mt.status }
}
