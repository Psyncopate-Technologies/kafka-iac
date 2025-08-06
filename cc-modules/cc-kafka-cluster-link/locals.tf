locals {
  linker_sa_name            = "${var.link_name}-linker"
  local_api_key_name        = "${var.link_name}-local-api-key"
  remote_api_key_name       = "${var.link_name}-remote-api-key"

  local_environment_id      = data.confluent_kafka_cluster.local.environment[0].id
  remote_environment_id     = data.confluent_kafka_cluster.remote.environment[0].id

  local_rest_endpoint       = data.confluent_kafka_cluster.local.rest_endpoint
  remote_bootstrap_endpoint = data.confluent_kafka_cluster.remote.bootstrap_endpoint

  local_cluster_rbac_crn    = data.confluent_kafka_cluster.local.rbac_crn
}
