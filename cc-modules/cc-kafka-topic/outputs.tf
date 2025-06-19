output "topic_id" {
  value       = confluent_kafka_topic.cc_kafka_topic.id
  description = "The ID of the Topic being created in Confluent Cloud"
}