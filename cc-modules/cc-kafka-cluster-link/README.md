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
| [confluent_environment.local](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/environment) | data source |
| [confluent_environment.remote](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/environment) | data source |
| [confluent_kafka_cluster.local](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |
| [confluent_kafka_cluster.remote](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/kafka_cluster) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_link_name"></a> [link\_name](#input\_link\_name) | Cluster link name (e.g., GCP.DEV.MAL.TOPIC) | `string` | `"GCP.DEV.MAL.TOPIC"` | no |
| <a name="input_linker_service_account_name"></a> [linker\_service\_account\_name](#input\_linker\_service\_account\_name) | Service account name for cluster linking | `string` | `"poc-cluster-linker"` | no |
| <a name="input_local_environment_name"></a> [local\_environment\_name](#input\_local\_environment\_name) | Display name of the local environment | `string` | n/a | yes |
| <a name="input_local_kafka_cluster_name"></a> [local\_kafka\_cluster\_name](#input\_local\_kafka\_cluster\_name) | Display name of the local Kafka cluster | `string` | n/a | yes |
| <a name="input_remote_environment_name"></a> [remote\_environment\_name](#input\_remote\_environment\_name) | Display name of the remote environment | `string` | n/a | yes |
| <a name="input_remote_kafka_cluster_name"></a> [remote\_kafka\_cluster\_name](#input\_remote\_kafka\_cluster\_name) | Display name of the remote Kafka cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linker_service_account_name"></a> [linker\_service\_account\_name](#output\_linker\_service\_account\_name) | The name of the service account used for the cluster link |
| <a name="output_local_cluster_rbac_crn"></a> [local\_cluster\_rbac\_crn](#output\_local\_cluster\_rbac\_crn) | RBAC CRN of the local Kafka cluster |
| <a name="output_local_environment_id"></a> [local\_environment\_id](#output\_local\_environment\_id) | Environment ID for the local Kafka cluster |
| <a name="output_local_rest_endpoint"></a> [local\_rest\_endpoint](#output\_local\_rest\_endpoint) | REST endpoint for the local Kafka cluster |
| <a name="output_remote_bootstrap_endpoint"></a> [remote\_bootstrap\_endpoint](#output\_remote\_bootstrap\_endpoint) | Bootstrap endpoint for the remote Kafka cluster |
| <a name="output_remote_environment_id"></a> [remote\_environment\_id](#output\_remote\_environment\_id) | Environment ID for the remote Kafka cluster |
