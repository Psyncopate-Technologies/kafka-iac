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
| [confluent_api_key.local](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/api_key) | resource |
| [confluent_api_key.remote](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/api_key) | resource |
| [confluent_cluster_link.this](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/cluster_link) | resource |
| [confluent_role_binding.linker_binding](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/role_binding) | resource |
| [confluent_service_account.linker](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/service_account) | resource |
| [confluent_kafka_cluster.local](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |
| [confluent_kafka_cluster.remote](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API Key (Org Admin) | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API Secret (Org Admin) | `string` | n/a | yes |
| <a name="input_link_name"></a> [link\_name](#input\_link\_name) | Cluster link name (e.g., GCP.DEV.MAL.TOPIC) | `string` | `"GCP.DEV.MAL.TOPIC"` | no |
| <a name="input_linker_service_account_name"></a> [linker\_service\_account\_name](#input\_linker\_service\_account\_name) | Service account name for cluster linking | `string` | `"poc-cluster-linker"` | no |
| <a name="input_local_cluster_id"></a> [local\_cluster\_id](#input\_local\_cluster\_id) | Kafka cluster ID (local) | `string` | n/a | yes |
| <a name="input_local_environment_id"></a> [local\_environment\_id](#input\_local\_environment\_id) | Environment ID of the local Kafka cluster | `string` | n/a | yes |
| <a name="input_remote_cluster_id"></a> [remote\_cluster\_id](#input\_remote\_cluster\_id) | Kafka cluster ID (remote) | `string` | n/a | yes |
| <a name="input_remote_environment_id"></a> [remote\_environment\_id](#input\_remote\_environment\_id) | Environment ID of the remote Kafka cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_link_name"></a> [cluster\_link\_name](#output\_cluster\_link\_name) | n/a |
| <a name="output_local_api_key_id"></a> [local\_api\_key\_id](#output\_local\_api\_key\_id) | n/a |
| <a name="output_remote_api_key_id"></a> [remote\_api\_key\_id](#output\_remote\_api\_key\_id) | n/a |
| <a name="output_service_account_id"></a> [service\_account\_id](#output\_service\_account\_id) | n/a |
