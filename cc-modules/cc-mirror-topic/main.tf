resource "confluent_kafka_mirror_topic" "this" {
  count = var.delete_after_migration ? 0 : 1

  mirror_topic_name = var.mirror_topic_name

  source_kafka_topic {
    topic_name = var.source_topic_name
  }

  cluster_link {
    link_name = var.cluster_link_name
  }

  kafka_cluster {
    id            = data.confluent_kafka_cluster.kafka_cluster.id
    rest_endpoint = data.confluent_kafka_cluster.kafka_cluster.rest_endpoint
  }

  status = var.mirror_topic_status

}
