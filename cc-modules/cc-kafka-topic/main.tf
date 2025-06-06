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

  # Optional 'retention' field (e.g. "5s", "3m", "2h", "1d")
  raw_retention = try(local.topic.retention, null)

  # Retention in milliseconds (only if defined)
  retention_ms = local.raw_retention == null ? null : (
    can(regex("^\\d+s$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 1000 :
    can(regex("^\\d+m$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 60 * 1000 :
    can(regex("^\\d+h$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 60 * 60 * 1000 :
    can(regex("^\\d+d$", local.raw_retention)) ? tonumber(regexall("^\\d+", local.raw_retention)[0]) * 24 * 60 * 60 * 1000 :
    null
  )

  # Cleanup policy optional field
  cleanup_policy = try(local.topic.cleanup_policy, null)

  # Final config: merge user-supplied config with calculated retention.ms (if defined)
  final_config = merge(
    local.topic_config_map,
    local.retention_ms == null ? {} : { "retention.ms" = tostring(local.retention_ms) },
    local.cleanup_policy == null ? {} : { "cleanup.policy" = tostring(local.cleanup_policy) }
  )
}

data "confluent_environment" "this" {
  display_name = var.environment_name
}

data "confluent_kafka_cluster" "this" {
  display_name = var.kafka_cluster_name
  environment {
    id = data.confluent_environment.this.id
  }
}

resource "confluent_kafka_topic" "this" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.this.id
  }

  topic_name        = local.topic.name
  partitions_count  = local.partitions_count
  config = local.final_config == null ? {} : local.final_config

  credentials {
    key    = var.kafka_api_key
    secret = var.kafka_api_secret
  }

  rest_endpoint = data.confluent_kafka_cluster.this.rest_endpoint
}
