<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
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
| [confluent_kafka_topic.cc_kafka_topic](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/kafka_topic) | resource |
| [confluent_tag.ClientSRBNumber](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/tag) | resource |
| [confluent_tag.clientMAL](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/tag) | resource |
| [confluent_tag_binding.ClientMALBinding](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/tag_binding) | resource |
| [confluent_tag_binding.ClientSRBBinding](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/tag_binding) | resource |
| [confluent_environment.cc_environment](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.cc_kafka_cluster](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |
| [confluent_schema_registry_cluster.cc_sr_cluster](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/schema_registry_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_mal_tag"></a> [create\_mal\_tag](#input\_create\_mal\_tag) | Should Client MAL tag be created? This is used to create a tag for the topic if it does not already exist. | `bool` | `false` | no |
| <a name="input_create_srb_tag"></a> [create\_srb\_tag](#input\_create\_srb\_tag) | Should Client SRB Review # tag be created? This is used to create a tag for the topic if it does not already exist. | `bool` | `false` | no |
| <a name="input_default_partitions"></a> [default\_partitions](#input\_default\_partitions) | Default number of partitions for the topic if not specified in the YAML file. The default value here will be overridden from terragrunt based on environment. | `number` | `3` | no |
| <a name="input_topic_config_raw"></a> [topic\_config\_raw](#input\_topic\_config\_raw) | Parsed topic configuration from YAML file. | `any` | n/a | yes |
| <a name="input_topic_name"></a> [topic\_name](#input\_topic\_name) | The name of the topic to be created. This is used to validate the naming convention of the topic. | `string` | n/a | yes |
| <a name="input_topic_path"></a> [topic\_path](#input\_topic\_path) | Absolute path to the YAML file defining the topic configuration (must be a single-topic YAML). | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_topic_id"></a> [topic\_id](#output\_topic\_id) | The ID of the Topic being created in Confluent Cloud |
<!-- END_TF_DOCS -->