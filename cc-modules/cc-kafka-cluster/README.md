# Confluent Cloud Kafka Cluster Terraform Module
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
| [confluent_kafka_cluster.this](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/kafka_cluster) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider) | Cloud provider to deploy Kafka cluster to | `string` | n/a | yes |
| <a name="input_cloud_region"></a> [cloud\_region](#input\_cloud\_region) | Cloud region of the cluster in the specified cloud provider | `string` | n/a | yes |
| <a name="input_cluster_ckus"></a> [cluster\_ckus](#input\_cluster\_ckus) | The number of Confluent Kafka Units (CKUs) to allocate to the cluster for cluster scale | `number` | n/a | yes |
| <a name="input_cluster_multi_zone_available"></a> [cluster\_multi\_zone\_available](#input\_cluster\_multi\_zone\_available) | The availability zone configuration of the Kafka cluster | `bool` | n/a | yes |
| <a name="input_cluster_number"></a> [cluster\_number](#input\_cluster\_number) | Monotonically increasing integer used as a suffix for cluster name, 1 <= cluster\_number <= 99 | `number` | n/a | yes |
| <a name="input_confluent_cloud_environment_name"></a> [confluent\_cloud\_environment\_name](#input\_confluent\_cloud\_environment\_name) | Confluent Cloud environment name for the environment that the cluster belongs to | `string` | n/a | yes |
| <a name="input_confluent_cloud_network_name"></a> [confluent\_cloud\_network\_name](#input\_confluent\_cloud\_network\_name) | Confluent Cloud network name for the network that the cluster uses | `string` | n/a | yes |
| <a name="input_environment_name"></a> [environment\_name](#input\_environment\_name) | Deployment environment of cluster: 'dev', 'test', or 'prod' | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cluster_availability_zones"></a> [cluster\_availability\_zones](#output\_cluster\_availability\_zones) | The list of cloud provider zones the cluster is in |
| <a name="output_cluster_bootstrap_endpoint"></a> [cluster\_bootstrap\_endpoint](#output\_cluster\_bootstrap\_endpoint) | The bootstrap endpoint used by Kafka clients to connect to the Kafka cluster |
| <a name="output_cluster_id"></a> [cluster\_id](#output\_cluster\_id) | The ID of the Kafka cluster (e.g. 'lkc-abc123') |
| <a name="output_cluster_rest_endpoint"></a> [cluster\_rest\_endpoint](#output\_cluster\_rest\_endpoint) | The REST endpoint of the Kafka cluster |
<!-- END_TF_DOCS -->