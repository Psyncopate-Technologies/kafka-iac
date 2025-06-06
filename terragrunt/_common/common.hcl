# Common TF configs
inputs = {
  confluent_api_key    = get_env("CONFLUENT_API_KEY")
  confluent_api_secret = get_env("CONFLUENT_API_SECRET")
  kafka_api_key        = get_env("KAFKA_API_KEY")
  kafka_api_secret     = get_env("KAFKA_API_SECRET")
  environment_name     = get_env("ENVIRONMENT_NAME")
  kafka_cluster_name  = get_env("KAFKA_CLUSTER_NAME")
}