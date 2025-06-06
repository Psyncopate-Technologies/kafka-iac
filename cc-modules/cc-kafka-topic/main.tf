## Support Multipl Topics in one file

# terraform {
#   required_providers {
#     confluent = {
#       source  = "confluentinc/confluent"
#       version = "2.25.0"
#     }
#   }
# }

# locals {
#   topic_config = yamldecode(file(var.topic_path))
# }

# resource "confluent_kafka_topic" "this" {
#   for_each = { for topic in local.topic_config.topics : topic.name => topic }

#   kafka_cluster {
#     id = var.kafka_cluster_id
#   }

#   topic_name    = each.value.name
#   partitions_count = each.value.partitions
#   config = each.value.config

#   credentials {
#     key    = var.kafka_api_key
#     secret = var.kafka_api_secret
#   }
#   rest_endpoint      = var.kafka_rest_endpoint
# }

## Support for single topic per yaml file


locals {
  topic_config = yamldecode(file(var.topic_path))
  topic        = local.topic_config.topic
  partitions_count = try(local.topic.partitions, var.default_partitions)
  topic_config_map = try(local.topic.config, null)
}

resource "confluent_kafka_topic" "this" {
  kafka_cluster {
    id = var.kafka_cluster_id
  }

  topic_name        = local.topic.name
  partitions_count  = local.partitions_count
  
  dynamic "config" {
    for_each = local.topic_config_map == null ? [] : [1]
    content {
      for key, value in local.topic_config_map :
      key => value
    }
  }

  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }

  rest_endpoint = var.kafka_rest_endpoint
}
