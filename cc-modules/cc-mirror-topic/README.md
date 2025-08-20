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
| <a name="input_cluster_link_name"></a> [cluster\_link\_name](#input\_cluster\_link\_name) | Name of the cluster link used for mirroring | `string` | n/a | yes |
| <a name="input_delete_after_migration"></a> [delete\_after\_migration](#input\_delete\_after\_migration) | If true, mirror topic will not be created (count=0) and destroy will be allowed | `bool` | `false` | no |
| <a name="input_mirror_topic_config_raw"></a> [mirror\_topic\_config\_raw](#input\_mirror\_topic\_config\_raw) | Raw YAML string defining mirror topic configuration. | `string` | n/a | yes |
| <a name="input_mirror_topic_name"></a> [mirror\_topic\_name](#input\_mirror\_topic\_name) | Name of the mirror topic | `string` | n/a | yes |
| <a name="input_mirror_topic_status"></a> [mirror\_topic\_status](#input\_mirror\_topic\_status) | Mirror topic status: ACTIVE, PAUSED, PROMOTED, or FAILED\_OVER | `string` | `"ACTIVE"` | no |
| <a name="input_mirror_topics_yaml_file"></a> [mirror\_topics\_yaml\_file](#input\_mirror\_topics\_yaml\_file) | Path to the YAML file containing mirror topic specifications | `string` | n/a | yes |
| <a name="input_target_cluster_name"></a> [target\_cluster\_name](#input\_target\_cluster\_name) | Target cluster name | `string` | n/a | yes |
| <a name="input_target_env_name"></a> [target\_env\_name](#input\_target\_env\_name) | Target environment name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_link_name"></a> [cluster\_link\_name](#output\_cluster\_link\_name) | Name of the cluster link used for mirroring |
| <a name="output_kafka_cluster_id"></a> [kafka\_cluster\_id](#output\_kafka\_cluster\_id) | ID of the Kafka cluster where mirror topic is created |
| <a name="output_kafka_cluster_rest_endpoint"></a> [kafka\_cluster\_rest\_endpoint](#output\_kafka\_cluster\_rest\_endpoint) | REST endpoint of the Kafka cluster |
| <a name="output_mirror_topic_name"></a> [mirror\_topic\_name](#output\_mirror\_topic\_name) | Name of the mirror topic created |
| <a name="output_mirror_topic_status"></a> [mirror\_topic\_status](#output\_mirror\_topic\_status) | Status of the mirror topic |
| <a name="output_source_topic_name"></a> [source\_topic\_name](#output\_source\_topic\_name) | Name of the source Kafka topic |
