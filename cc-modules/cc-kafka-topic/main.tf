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


resource "confluent_kafka_topic" "cc_kafka_topic" {
  kafka_cluster {
    id = data.confluent_kafka_cluster.cc_kafka_cluster.id
  }
  rest_endpoint = data.confluent_kafka_cluster.cc_kafka_cluster.rest_endpoint

  credentials {
    key    = var.cc_kafka_api_key
    secret = var.cc_kafka_api_secret
  }

  topic_name       = var.topic_name
  partitions_count = local.partitions_count
  config           = local.final_config == null ? {} : local.final_config

  # lifecycle {
  #   prevent_destroy = true
  # }
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

## Logic to check if the tags for ClientMAL and ClientSRBNumber already exists is taken care as part of before_hook in terragrunt
## Logic to create Tags for Client Metadata if the tags does not exists
resource "confluent_tag" "clientMAL" {
  count = var.create_mal_tag ? 1 : 0
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  name        = local.topic.mal_acronym
  description = "Client MAL tag"

  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "confluent_tag" "ClientSRBNumber" {
  count = var.create_srb_tag ? 1 : 0
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  name        = local.topic.srb_review_number
  description = "Client SRB Board Review Number"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

## Logic to bind Tags for Client Metadata
resource "confluent_tag_binding" "ClientMALBinding" {
  depends_on = [confluent_tag.clientMAL, confluent_kafka_topic.cc_kafka_topic]
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  tag_name    = local.topic.mal_acronym
  entity_name = "${data.confluent_schema_registry_cluster.cc_sr_cluster.id}:${data.confluent_kafka_cluster.cc_kafka_cluster.id}:${var.topic_name}"
  entity_type = "kafka_topic"

  # lifecycle {
  #   prevent_destroy = true
  # }
}
resource "confluent_tag_binding" "ClientSRBBinding" {
  depends_on = [confluent_tag.ClientSRBNumber, confluent_kafka_topic.cc_kafka_topic]
  schema_registry_cluster {
    id = data.confluent_schema_registry_cluster.cc_sr_cluster.id
  }
  rest_endpoint = data.confluent_schema_registry_cluster.cc_sr_cluster.rest_endpoint
  credentials {
    key    = var.cc_sr_api_key
    secret = var.cc_sr_api_secret
  }

  tag_name    = local.topic.srb_review_number
  entity_name = "${data.confluent_schema_registry_cluster.cc_sr_cluster.id}:${data.confluent_kafka_cluster.cc_kafka_cluster.id}:${var.topic_name}"
  entity_type = "kafka_topic"

  # lifecycle {
  #   prevent_destroy = true
  # }
}

