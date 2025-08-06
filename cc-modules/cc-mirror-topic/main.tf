provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

resource "confluent_kafka_mirror_topic" "this" {
  for_each = {
    for topic in local.mirror_topics : topic.mirror_topic_name => topic
  }

  source_kafka_topic {
    topic_name = each.value.source_kafka_topic.topic_name
  }

  cluster_link {
    link_name = each.value.cluster_link.link_name
  }

  kafka_cluster {
    id            = data.confluent_kafka_cluster.mirror_clusters[each.key].id
    rest_endpoint = data.confluent_kafka_cluster.mirror_clusters[each.key].rest_endpoint
    credentials {
      key    = var.confluent_cloud_api_key
      secret = var.confluent_cloud_api_secret
    }
  }

  mirror_topic_name = each.value.mirror_topic_name

  lifecycle {
    prevent_destroy = true
  }
}
