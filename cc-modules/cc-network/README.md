# Confluent Cloud Network Terraform Module
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version  |
|---------------------------------------------------------------------------|----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.8 |
| <a name="requirement_confluent"></a> [confluent](#requirement\_confluent) | 2.30.0   |

## Providers

| Name                                                                | Version |
|---------------------------------------------------------------------|---------|
| <a name="provider_confluent"></a> [confluent](#provider\_confluent) | 2.30.0  |

## Modules

No modules.

## Resources

| Name                                                                                                                                                          | Type        |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------|-------------|
| [confluent_network.private_link_network](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/network)                        | resource    |
| [confluent_private_link_access.private_link_access](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/resources/private_link_access) | resource    |
| [confluent_environment.cc_environment](https://registry.terraform.io/providers/confluentinc/confluent/2.30.0/docs/data-sources/environment)                   | data source |

## Inputs

| Name                                                                                                                                       | Description                                                                      | Type     | Default     | Required |
|--------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|----------|-------------|:--------:|
| <a name="input_cloud_provider"></a> [cloud\_provider](#input\_cloud\_provider)                                                             | Cloud provider to deploy Kafka cluster to                                        | `string` | `"AZURE"`   |    no    |
| <a name="input_confluent_cloud_environment_name"></a> [confluent\_cloud\_environment\_name](#input\_confluent\_cloud\_environment\_name)   | The name of the Confluent Cloud Environment that the Network belongs to.         | `string` | n/a         |   yes    |
| <a name="input_customer_azure_subscription_id"></a> [customer\_azure\_subscription\_id](#input\_customer\_azure\_subscription\_id)         | Your Azure Subscription ID that will be granted Private Link Access.             | `string` | n/a         |   yes    |
| <a name="input_network_display_name"></a> [network\_display\_name](#input\_network\_display\_name)                                         | The name of the Confluent Cloud Network for Azure Private Link.                  | `string` | n/a         |   yes    |
| <a name="input_private_link_access_display_name"></a> [private\_link\_access\_display\_name](#input\_private\_link\_access\_display\_name) | The name of the Private Link Access entry (allows your subscription to connect). | `string` | n/a         |   yes    |
| <a name="input_private_link_dns_resolution"></a> [private\_link\_dns\_resolution](#input\_private\_link\_dns\_resolution)                  | Network DNS resolution for PrivateLink. Can be 'CHASED\_PRIVATE' or 'PRIVATE'.   | `string` | `"PRIVATE"` |    no    |
| <a name="input_region"></a> [region](#input\_region)                                                                                       | The Azure region where the network will exist (e.g., 'eastus', 'centralus').     | `string` | n/a         |   yes    |

## Outputs

| Name                                                                                                                                    | Description                                          |
|-----------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------|
| <a name="output_confluent_network_aws_info"></a> [confluent\_network\_aws\_info](#output\_confluent\_network\_aws\_info)                | The AWS info of Confluent Cloud Network.             |
| <a name="output_confluent_network_azure_info"></a> [confluent\_network\_azure\_info](#output\_confluent\_network\_azure\_info)          | The AZURE info of Confluent Cloud Network.           |
| <a name="output_confluent_network_dns_domain"></a> [confluent\_network\_dns\_domain](#output\_confluent\_network\_dns\_domain)          | The DNS Domain of Confluent Cloud Network.           |
| <a name="output_confluent_network_gcp_info"></a> [confluent\_network\_gcp\_info](#output\_confluent\_network\_gcp\_info)                | The GCP info of Confluent Cloud Network.             |
| <a name="output_confluent_network_id"></a> [confluent\_network\_id](#output\_confluent\_network\_id)                                    | The ID of the created Confluent Cloud Network.       |
| <a name="output_confluent_network_name"></a> [confluent\_network\_name](#output\_confluent\_network\_name)                              | The name of Confluent Cloud Network.                 |
| <a name="output_confluent_network_resource_name"></a> [confluent\_network\_resource\_name](#output\_confluent\_network\_resource\_name) | The Resource Name of the Confluent Cloud Network.    |
| <a name="output_confluent_network_zone_info"></a> [confluent\_network\_zone\_info](#output\_confluent\_network\_zone\_info)             | The Zone Info of Confluent Cloud Network.            |
| <a name="output_private_link_access_id"></a> [private\_link\_access\_id](#output\_private\_link\_access\_id)                            | The ID of the Confluent Cloud Private Link Access.   |
| <a name="output_private_link_access_name"></a> [private\_link\_access\_name](#output\_private\_link\_access\_name)                      | The name of the Confluent Cloud Private Link Access. |
<!-- END_TF_DOCS -->