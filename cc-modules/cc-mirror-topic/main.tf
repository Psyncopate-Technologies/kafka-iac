terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = ">= 2.32.0"
    }
  }
}

provider "confluent" {
  cloud_api_key    = var.confluent_cloud_api_key
  cloud_api_secret = var.confluent_cloud_api_secret
}

resource "confluent_kafka_mirror_topic" "this" {
  for_each = {
    for topic in var.mirror_topics : topic.mirror_topic_name => topic
  }

  source_kafka_topic {
    topic_name = each.value.source_kafka_topic.topic_name
  }

  cluster_link {
    link_name = each.value.cluster_link.link_name
  }

  kafka_cluster {
    id            = each.value.kafka_cluster.id
    rest_endpoint = each.value.kafka_cluster.rest_endpoint
    credentials {
      key    = each.value.kafka_cluster.credentials.key
      secret = each.value.kafka_cluster.credentials.secret
    }
  }

  mirror_topic_name = each.value.mirror_topic_name

  lifecycle {
    prevent_destroy = true
  }
}
