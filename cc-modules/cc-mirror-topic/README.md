## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.12.2 |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 2.30.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [confluent_kafka_mirror_topic.this](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/kafka_mirror_topic) | resource |
| [confluent_environment.kafka_env](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.kafka_cluster](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_replications"></a> [replications](#input\_replications) | Map of mirror topics to create, keyed by provider-region | <pre>map(object({<br/>    mirror_topic_status = string<br/>    mirror_topic_name   = string<br/>    cluster_link_name   = string<br/>    target_cluster_name = string<br/>    target_env_name     = string<br/>  }))</pre> | n/a | yes |
| <a name="input_source_topic_name"></a> [source\_topic\_name](#input\_source\_topic\_name) | Source Kafka topic name | `string` | n/a | yes |
| <a name="input_target_cluster_api_key"></a> [target\_cluster\_api\_key](#input\_target\_cluster\_api\_key) | API Key for target Kafka cluster | `string` | n/a | yes |
| <a name="input_target_cluster_api_secret"></a> [target\_cluster\_api\_secret](#input\_target\_cluster\_api\_secret) | API Secret for target Kafka cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_link_names"></a> [cluster\_link\_names](#output\_cluster\_link\_names) | Cluster link names used for each mirror topic |
| <a name="output_kafka_cluster_ids"></a> [kafka\_cluster\_ids](#output\_kafka\_cluster\_ids) | IDs of Kafka clusters where mirror topics are created |
| <a name="output_kafka_cluster_rest_endpoints"></a> [kafka\_cluster\_rest\_endpoints](#output\_kafka\_cluster\_rest\_endpoints) | REST endpoints of Kafka clusters |
| <a name="output_mirror_topic_names"></a> [mirror\_topic\_names](#output\_mirror\_topic\_names) | Names of the mirror topics created |
| <a name="output_mirror_topic_statuses"></a> [mirror\_topic\_statuses](#output\_mirror\_topic\_statuses) | Statuses of the mirror topics |
| <a name="output_source_topic_name"></a> [source\_topic\_name](#output\_source\_topic\_name) | Name of the source Kafka topic |
