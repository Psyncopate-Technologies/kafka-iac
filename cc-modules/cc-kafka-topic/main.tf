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

data "confluent_environment" "cc_environment" {
  display_name = var.environment_name
}

data "confluent_kafka_cluster" "cc_kafka_cluster" {
  display_name = var.cc_kafka_cluster_name
  environment {
    id = data.confluent_environment.cc_environment.id
  }
}

resource "confluent_kafka_topic" "cc_kafka_topic" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cc_kafka_cluster.id
  }
  rest_endpoint = data.confluent_kafka_cluster.cc_kafka_cluster.rest_endpoint

  credentials {
    key    = var.cc_kafka_api_key
    secret = var.cc_kafka_api_secret
  }

  topic_name        = var.topic_name
  partitions_count  = local.partitions_count
  config = local.final_config == null ? {} : local.final_config  

  # lifecycle {
  #   prevent_destroy = true
  # }
}

data "confluent_schema_registry_cluster" "cc_sr_cluster" {
  environment {
    id = data.confluent_environment.cc_environment.id
  }
}

## Logic to retrieve the business metadata for the client - The Business metadata resource needs to be created as part of Platform resource provisioning
## Business Metadata in Confluent Cloud is applicable only for ADVANCED Stream governance package.
## To save cost, as an alternative, we can use the tagging
# data "confluent_business_metadata" "client_metadata" {
#   schema_registry_cluster {
#     id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
#   }
#   rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
#   credentials {
#     key    = var.cc_sr_api_key
#     secret = var.cc_sr_api_secret
#   }

#   name = "client_metadata"
# }

# ## Logic to create Business Metadata binding
# resource "confluent_business_metadata_binding" "client_md_binding" {
#   schema_registry_cluster {
#     id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
#   }
#   rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
#   credentials {
#     key    = var.cc_sr_api_key
#     secret = var.cc_sr_api_secret
#   }

#   business_metadata_name = confluent_business_metadata.client_metadata.name
#   entity_name = "${data.confluent_schema_registry_cluster.cc_sr_cluster.id}:${data.confluent_kafka_cluster.cc_kafka_cluster.id}:${var.topic_name}"
#   entity_type = "kafka_topic"
#   attributes = {
#     "MAL" = local.topic.mal_acronym
#     "SRB_REVIEW_NUMBER" = local.topic.srb_review_number
#   }

#   # lifecycle {
#   #   prevent_destroy = true
#   # }
# }

## Logic to create Tags for Client Metadata
resource "confluent_tag" "clientMAL" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  name = local.topic.mal_acronym
  description = "Client MAL tag"

  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "confluent_tag" "ClientSRBNumber" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  name = local.topic.srb_review_number
  description = "Client SRB Board Review Number"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

## Logic to bind Tags for Client Metadata
resource "confluent_tag_binding" "ClientMALBinding" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  tag_name = local.topic.mal_acronym
  entity_name = "${data.confluent_schema_registry_cluster.cc_sr_cluster.id}:${data.confluent_kafka_cluster.cc_kafka_cluster.id}:${var.topic_name}"
  entity_type = "kafka_topic"

  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "confluent_tag_binding" "ClientSRBBinding" {
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  tag_name = local.topic.srb_review_number
  entity_name = "${data.confluent_schema_registry_cluster.cc_sr_cluster.id}:${data.confluent_kafka_cluster.cc_kafka_cluster.id}:${var.topic_name}"
  entity_type = "kafka_topic"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

