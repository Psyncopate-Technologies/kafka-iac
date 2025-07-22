confluent_cloud_api_key    = "your-api-key"
confluent_cloud_api_secret = "your-api-secret"

target_kafka_cluster_id = "lkc-abc123"

mirror_topics = [
  {
    mirror_topic_name = "orders.mirror"

    source_kafka_topic = {
      topic_name = "orders"
    }

    cluster_link = {
      link_name = "east-to-west"
    }

    kafka_cluster = {
      id            = "lkc-abc123"
      rest_endpoint = "https://abc.us-central1.gcp.confluent.cloud"
      credentials = {
        key    = "YOUR_API_KEY"
        secret = "YOUR_API_SECRET"
      }
    }

    prevent_destroy = true
  }
]

