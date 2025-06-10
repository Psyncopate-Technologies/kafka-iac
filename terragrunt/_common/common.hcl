# Common TF configs
inputs = {
  confluent_api_key    = get_env("CONFLUENT_API_KEY")
  confluent_api_secret = get_env("CONFLUENT_API_SECRET")
  cc_kafka_api_key     = get_env("CC_KAFKA_API_KEY")
  cc_kafka_api_secret  = get_env("CC_KAFKA_API_SECRET")
  cc_sr_api_key        = get_env("CC_SR_API_KEY")
  cc_sr_api_secret     = get_env("CC_SR_API_SECRET")
  cc_sr_endpoint     = get_env("CC_SR_ENDPOINT")
  environment_name     = get_env("ENVIRONMENT_NAME")
  cc_kafka_cluster_name= get_env("CC_KAFKA_CLUSTER_NAME")
}