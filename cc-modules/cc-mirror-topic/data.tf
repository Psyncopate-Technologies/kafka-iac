data "confluent_kafka_cluster" "mirror_clusters" {
  for_each = {
    for topic in local.mirror_topics : topic.mirror_topic_name => topic
  }

  id = each.value.kafka_cluster.cluster_id

  environment {
    id = each.value.kafka_cluster.environment_id
  }
}
