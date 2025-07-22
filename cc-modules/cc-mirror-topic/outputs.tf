output "mirror_topic_names" {
  value = [for t in confluent_kafka_mirror_topic.this : t.mirror_topic_name]
}
