output "mirror_topic_name" {
  description = "Name of the mirror topic created"
  value       = confluent_kafka_mirror_topic.this.mirror_topic_name
}

output "source_topic_name" {
  description = "Name of the source Kafka topic"
  value       = confluent_kafka_mirror_topic.this.source_kafka_topic[0].topic_name
}

output "cluster_link_name" {
  description = "Name of the cluster link used for mirroring"
  value       = confluent_kafka_mirror_topic.this.cluster_link[0].link_name
}

output "kafka_cluster_id" {
  description = "ID of the Kafka cluster where mirror topic is created"
  value       = confluent_kafka_mirror_topic.this.kafka_cluster[0].id
}

output "kafka_cluster_rest_endpoint" {
  description = "REST endpoint of the Kafka cluster"
  value       = confluent_kafka_mirror_topic.this.kafka_cluster[0].rest_endpoint
}
