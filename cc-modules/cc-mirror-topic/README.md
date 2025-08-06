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
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API Key | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API Secret | `string` | n/a | yes |
| <a name="input_mirror_topic_config_raw"></a> [mirror\_topic\_config\_raw](#input\_mirror\_topic\_config\_raw) | Raw YAML string defining mirror topic configuration. | `string` | n/a | yes |
| <a name="input_mirror_topics_yaml_file"></a> [mirror\_topics\_yaml\_file](#input\_mirror\_topics\_yaml\_file) | Path to the YAML file containing mirror topic specifications | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_link_name"></a> [cluster\_link\_name](#output\_cluster\_link\_name) | Name of the cluster link used for mirroring |
| <a name="output_kafka_cluster_id"></a> [kafka\_cluster\_id](#output\_kafka\_cluster\_id) | ID of the Kafka cluster where mirror topic is created |
| <a name="output_kafka_cluster_rest_endpoint"></a> [kafka\_cluster\_rest\_endpoint](#output\_kafka\_cluster\_rest\_endpoint) | REST endpoint of the Kafka cluster |
| <a name="output_mirror_topic_name"></a> [mirror\_topic\_name](#output\_mirror\_topic\_name) | Name of the mirror topic created |
| <a name="output_source_topic_name"></a> [source\_topic\_name](#output\_source\_topic\_name) | Name of the source Kafka topic |
