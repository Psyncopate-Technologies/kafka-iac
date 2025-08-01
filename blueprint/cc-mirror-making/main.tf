module "cc-mirror-topic" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-mirror-topic?ref=cc-cluster-link"

  confluent_cloud_api_key    = var.confluent_cloud_api_key
  confluent_cloud_api_secret = var.confluent_cloud_api_secret
  mirror_topics              = var.mirror_topics

  target_kafka_cluster_id    = var.target_kafka_cluster_id       
}
