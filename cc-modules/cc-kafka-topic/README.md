# Confluent Cloud Kafka Topic Terraform Module

This Terraform module provisions a Kafka topic in Confluent Cloud by parsing a YAML-based interface file. 

It is designed to be used with [Terragrunt](https://terragrunt.gruntwork.io/) and supports flexible, declarative topic definitions.

---

## Features

- Parses a YAML file to configure Kafka topic attributes
- Supports optional and required topic fields
- Allows environment-specific defaults via Terragrunt
- Compatible with multiple cloud backends (Azure, AWS, GCP)
- Merges additional topic configuration via YAML or derived logic

---

## Inputs
| Name                   | Type     | Required | Default | Description                                                                                                                                        |
| ---------------------- | -------- | -------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| `confluent_api_key`    | `string` | Yes    | —       | API key for authenticating with the Confluent Cloud control plane (used in the `provider` block).                                                  |
| `confluent_api_secret` | `string` | Yes    | —       | API secret for the Confluent Cloud control plane.                                                                                                  |
| `cc_kafka_api_key`        | `string` | Yes    | —       | Kafka API key for authenticating with the Kafka REST API.                                                                                          |
| `cc_kafka_api_secret`     | `string` | Yes    | —       | Kafka API secret for the Kafka REST API.                                                                                                           |
| `cc_sr_api_key`        | `string` | Yes    | —       | Schema Registry API key for authenticating with the Kafka REST API.                                                                                          |
| `cc_sr_api_secret`     | `string` | Yes    | —       | Schema Registry API secret for the Kafka REST API.                                                                                                           |
| `environment_name`     | `string` | Yes    | —       | The Confluent Cloud Environment Name. Cannot be empty.                                                                           |
| `cc_kafka_cluster_name`   | `string` | Yes    | —       | Kafka Cluster Name. Cannot be empty                   |
| `topic_path`           | `string` | Yes    | —       | Absolute path to the YAML file defining the topic configuration. Must point to a `.yaml` or `.yml` file.                                           |
| `default_partitions`   | `number` | No     | `3`     | Default number of partitions to use if not specified in the YAML file. This value is typically overridden via Terragrunt based on the environment. |


## Outputs
| Name                   | Description                                                        |
| ---------------------- | ------------------------------------------------------------------ |
| `topic_id`             | The full ID of the Kafka topic                                     |
| `pipeline_version`     | The version of the module used (via `pipeline_version` or default) |


