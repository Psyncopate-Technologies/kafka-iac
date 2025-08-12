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
        display_name       = "dummy-cluster"
        rest_endpoint      = "https://rest.dummy.kafka.mock"
        bootstrap_endpoint = "SASL_SSL://dummy.kafka.mock:9092"
        rbac_crn           = "crn://confluent.cloud/kafka=lkc-123"
        environment        = {
          id = "env-123"
        }
      }
    }
  }

variables {
  confluent_cloud_api_key    = "dummy-key"
  confluent_cloud_api_secret = "dummy-secret"

  mirror_topics_yaml_file = "" # unused if you pass raw yaml
  mirror_topic_config_raw = <<YAML
mirror_topic_name: mirror-topic-1
source_kafka_topic:
  topic_name: source-topic-1
cluster_link:
  link_name: test-link-1
kafka_cluster:
  cluster_name: dummy-cluster
  environment_name: dummy-env
status: "ACTIVE"                  # ACTIVE, PAUSED, PROMOTED, FAILED_OVER
delete_after_migration: false 
YAML
}
run "test_rest_endpoint_format" {
  command = plan

  assert {
    condition     = can(regex("^https://", output.kafka_cluster_rest_endpoint))
    error_message = "Kafka cluster REST endpoint must start with https://"
  }
}

run "test_mock_data_injection" {
  command = plan

  # Validate the environment id from mock
  assert {
    condition     = data.confluent_environment.kafka_env.id == "env-123"
    error_message = "Mocked environment ID should be 'env-123'"
  }

  # Validate kafka cluster display name from mock
  assert {
    condition     = data.confluent_kafka_cluster.kafka_cluster.display_name == "dummy-cluster"
    error_message = "Mocked kafka cluster display name should be 'dummy-cluster'"
  }
}

run "test_yaml_decoding" {
  command = plan

  # Check that local variable from yamldecode contains the right topic name
  assert {
    condition     = local.mirror_topic.mirror_topic_name == "mirror-topic-1"
    error_message = "YAML decoded mirror_topic_name should be 'mirror-topic-1'"
  }

  # Check cluster link name from YAML
  assert {
    condition     = local.mirror_topic.cluster_link.link_name == "test-link-1"
    error_message = "YAML decoded cluster link name should be 'test-link-1'"
  }
}

run "test_resource_properties" {
  command = plan

  # Check the cluster link name on resource
  assert {
    condition     = confluent_kafka_mirror_topic.this[0].cluster_link[0].link_name == "test-link-1"
    error_message = "Resource cluster_link name should be 'test-link-1'"
  }
}

run "test_output_status" {
  command = plan

  assert {
    condition     = output.mirror_topic_status == "ACTIVE"
    error_message = "Mirror topic status output should be 'ACTIVE'"
  }
}
