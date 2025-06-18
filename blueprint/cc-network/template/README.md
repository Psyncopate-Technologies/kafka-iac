# Blueprint - Confluent Cloud Network
This blueprint is for a Confluent Cloud Network

## Setup
1. Copy the files from the template folder to a new folder
2. Update the `module_repo_version_tag` in the `main.tf` file
3. Create a `terraform.tfvars` file with your configuration
4. Set up your `provider.tf` file

## Examples

### terraform.tfvars

```hcl
confluent_cloud_api_key = "**********************"
confluent_cloud_api_secret = "**********************"
network_display_name = "dev-confluent-network-azure"
region = "eastus"
private_link_dns_resolution = "PRIVATE"
private_link_access_display_name = "dev-confluent-network-azure-private-link"
customer_azure_subscription_id = "**********************"
confluent_cloud_environment_name = "DEV"
```


## Variables for Confluent Cloud Kafka Cluster

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
