mock_provider "confluent" {
  mock_data "confluent_environment" {
    defaults = { 
      id           = "env-123"
      display_name = "dummy-env"
    }
  }

  mock_data "confluent_kafka_cluster" {
    defaults = {
      id                 = "lkc-123"
      display_name       = "cluster-1"
      rest_endpoint      = "https://rest.dummy.kafka.mock"
      bootstrap_endpoint = "SASL_SSL://dummy.kafka.mock:9092"
      rbac_crn           = "crn://confluent.cloud/kafka=lkc-123"
      environment        = { id = "env-123" }
    }
  }
}

variables {
  replications = {
    "gcp-eastus2" = {
      target_provider     = "gcp"
      target_kafka_cluster_region = "eastus2"
      mirror_topic_name   = "mirror-topic-gcp-eastus2"
      cluster_link_name   = "link-gcp-eastus2"
      mirror_topic_status = "ACTIVE"
      target_cluster_name = "cluster-1"
      target_env_name     = "dummy-env"
      target_cluster_api_key    = "qwertyuiop"
      target_cluster_api_secret = "zxcvbnmsdf"
    }

    "azure-westus2" = {
      target_provider     = "azure"
      target_kafka_cluster_region = "westus2"
      mirror_topic_name   = "mirror-topic-azure-westus2"
      cluster_link_name   = "link-azure-westus2"
      mirror_topic_status = "PROMOTED"
      target_cluster_name = "cluster-2"
      target_env_name     = "dummy-env"  
      target_cluster_api_key    = "qwertyuiop"
      target_cluster_api_secret = "zxcvbnmsdf"
    }
  }

  source_topic_name         = "source-topic-1"

}

run "test_rest_endpoint_format" {
  command = plan

  assert {
    condition     = alltrue([for k, v in output.kafka_cluster_rest_endpoints : can(regex("^https://", v))])
    error_message = "All Kafka cluster REST endpoints must start with https://"
  }
}

run "test_mock_data_injection" {
  command = plan

  # Validate the environment id from mock for a specific instance
  assert {
    condition     = data.confluent_environment.kafka_env["gcp-eastus2"].id == "env-123"
    error_message = "Mocked environment ID should be 'env-123'"
  }

  # Validate kafka cluster display name from mock for a specific instance
  assert {
    condition     = data.confluent_kafka_cluster.kafka_cluster["gcp-eastus2"].display_name == "cluster-1"
    error_message = "Mocked kafka cluster display name should be 'cluster-1'"
  }
}


run "test_resource_properties" {
  command = plan

  # All cluster_link names must match expected mock values
  assert {
    condition = alltrue([
      for k, v in confluent_kafka_mirror_topic.this :
      v.cluster_link[0].link_name == "link-azure-westus2" || v.cluster_link[0].link_name == "link-gcp-eastus2"
    ])
    error_message = "All cluster_link names must match the expected values from mock inputs"
  }
}

run "test_output_status" {
  command = plan

  assert {
    condition = alltrue([
      for k, v in output.mirror_topic_statuses : 
      v == "PROMOTED" || v == "ACTIVE"
    ])
    error_message = "Mirror topic status outputs must match expected statuses"
  }
}