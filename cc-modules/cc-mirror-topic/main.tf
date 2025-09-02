resource "confluent_kafka_mirror_topic" "this" {
  for_each = var.replications

  mirror_topic_name = each.value.mirror_topic_name

  source_kafka_topic {
    topic_name = var.source_topic_name
  }

  cluster_link {
    link_name = each.value.cluster_link_name
  }

  kafka_cluster {
    id            = data.confluent_kafka_cluster.kafka_cluster[each.key].id
    rest_endpoint = data.confluent_kafka_cluster.kafka_cluster[each.key].rest_endpoint
    credentials {
      key    = var.target_cluster_api_key
      secret = var.target_cluster_api_secret
    }
  }

  status = each.value.mirror_topic_status
}
