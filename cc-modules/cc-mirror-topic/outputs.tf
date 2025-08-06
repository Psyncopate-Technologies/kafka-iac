output "mirror_topic_names" {
  description = "Names of all created mirror topics"
  value       = [for mt in confluent_kafka_mirror_topic.this : mt.mirror_topic_name]
}

output "mirror_topic_ids" {
  description = "IDs of all created mirror topics"
  value       = [for mt in confluent_kafka_mirror_topic.this : mt.id]
}

output "mirror_topic_details" {
  description = "Detailed info of all mirror topics"
  value       = { for k, mt in confluent_kafka_mirror_topic.this : k => {
    id                = mt.id
    mirror_topic_name = mt.mirror_topic_name
    source_topic      = mt.source_kafka_topic[0].topic_name
    cluster_link      = mt.cluster_link[0].link_name
  } }
}
