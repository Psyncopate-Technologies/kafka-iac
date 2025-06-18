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

| Name                                                                                                                                     | Type     |
|------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [confluent_network.private-link](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/confluent_network) | resource |

## Inputs

| Name                             | Description                                                                      | Type     | Default   | Required |
|----------------------------------|----------------------------------------------------------------------------------|----------|-----------|:--------:|
| confluent_cloud_api_key          | Confluent Cloud API Key for authentication.                                      | `string` | n/a       |   yes    |
| confluent_cloud_api_secret       | Confluent Cloud API Secret for authentication.                                   | `string` | n/a       |   yes    |
| network_display_name             | The name of the Confluent Cloud Network for Azure Private Link.                  | `string` | n/a       |   yes    |
| region                           | The Azure region where the network will exist (e.g., 'eastus', 'centralus').     | `string` | n/a       |   yes    |
| private_link_dns_resolution      | Network DNS resolution for PrivateLink. Can be 'CHASED_PRIVATE' or 'PRIVATE'.    | `string` | "PRIVATE" |   yes    |
| private_link_access_display_name | The name of the Private Link Access entry (allows your subscription to connect). | `string` | n/a       |   yes    |
| customer_azure_subscription_id   | Your Azure Subscription ID that will be granted Private Link Access.             | `string` | n/a       |   yes    |
| confluent_cloud_environment_name | The name of the Confluent Cloud Environment that the Network belongs to.         | `string` | n/a       |   yes    |

## Outputs

| Name                            | Description                                        |
|---------------------------------|----------------------------------------------------|
| confluent_network_id            | The ID of the created Confluent Cloud Network.     |
| confluent_network_resource_name | The Confluent Resource Name of the Network.        |
| private_link_access_id          | The ID of the Confluent Cloud Private Link Access. |

<!-- END_TF_DOCS -->