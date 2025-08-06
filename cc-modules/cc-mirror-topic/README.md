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
| [confluent_kafka_cluster.mirror_clusters](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |

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
| <a name="output_mirror_topic_details"></a> [mirror\_topic\_details](#output\_mirror\_topic\_details) | Detailed info of all mirror topics |
| <a name="output_mirror_topic_ids"></a> [mirror\_topic\_ids](#output\_mirror\_topic\_ids) | IDs of all created mirror topics |
| <a name="output_mirror_topic_names"></a> [mirror\_topic\_names](#output\_mirror\_topic\_names) | Names of all created mirror topics |
