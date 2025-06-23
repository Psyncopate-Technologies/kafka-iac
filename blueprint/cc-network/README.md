# Blueprint - Confluent Cloud Network
This blueprint is for a Confluent Cloud Network

## Setup
1. Copy the files from the template folder to a new folder
2. Update the `module_repo_version_tag` in the `main.tf` file
3. Create a `terraform.tfvars` file with your configuration (reference in `test/test.tfvars`)
4. Setup your `provider.tf` file

## Examples

### terraform.tfvars

```hcl
network_display_name = "azu-net-dev-eastus-01"
region = "eastus"
private_link_dns_resolution = "PRIVATE"
private_link_access_display_name = "azu-pla-dev-eastus-01"
customer_azure_subscription_id = "**********************"
confluent_cloud_environment_name = "dev"
```

### provider.tf
```hcl
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
    },

# If using Azure blob TF state storage
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.0"
    }
  }
}

provider "confluent" {
}

```

[More `confluent` provider information available here](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs)


### backend.tf
```hcl
# Example for Azure blob state storage backend
terraform {
     backend "azurerm" {
      resource_group_name  = "<resource_group_name>"
      storage_account_name = "<storage_account_name>"
      container_name       = "tfstate"
      key                  = "cc_kafka_cluster.tfstate"
  }
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

No providers.

## Modules

| Name                                                                 | Source                                                              | Version |
|----------------------------------------------------------------------|---------------------------------------------------------------------|---------|
| <a name="module_cc_network"></a> [cc\_network](#module\_cc\_network) | github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-network | n/a     |

## Resources

No resources.

## Inputs

| Name                                                                                                                                       | Description                                                                      | Type     | Default     | Required |
|--------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|----------|-------------|:--------:|
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key)                              | Confluent Cloud API Key for authentication.                                      | `string` | n/a         |   yes    |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret)                     | Confluent Cloud API Secret for authentication.                                   | `string` | n/a         |   yes    |
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