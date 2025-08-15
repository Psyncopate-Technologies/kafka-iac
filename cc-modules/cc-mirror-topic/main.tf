resource "confluent_kafka_mirror_topic" "this" {
  count = local.mirror_topic.delete_after_migration ? 0 : 1

  source_kafka_topic {
    topic_name = local.mirror_topic.source_kafka_topic.topic_name
  }

  cluster_link {
    link_name = local.mirror_topic.cluster_link.link_name
  }

  kafka_cluster {
    id            = data.confluent_kafka_cluster.kafka_cluster.id
    rest_endpoint = data.confluent_kafka_cluster.kafka_cluster.rest_endpoint
  }

  status = local.mirror_topic.status

  lifecycle {
    prevent_destroy = true
  }
}
