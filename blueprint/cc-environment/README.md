# Blueprint - Confluent Cloud Environment

This blueprint sets up a reusable Confluent Cloud Environment with Stream Governance enabled.

## Setup

1. Copy the files from this blueprint into your environment-specific repo
2. Update `module_repo_version_tag` in the `main.tf`
3. Create a `terraform.tfvars` file with your configuration
4. Add your `provider.tf` for the Confluent Cloud provider authentication

## Example

### terraform.tfvars


```hcl
cloud_provider       = "AZURE"
cloud_region         = "eastus2"
environment_name     = "dev"
environment_number       = 1
stream_governance_package = "ESSENTIALS"
module_repo_version_tag   = "v1.0.0"

### provider.tf
```hcl
terraform {
  required_providers {
    confluent = {
      source  = "confluentinc/confluent"
      version = "2.30.0"
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

## Variables for Confluent Cloud environment and Schema Registry

| Name                           | Description                                                                 | Type     | Default         | Required |
|--------------------------------|-----------------------------------------------------------------------------|----------|------------------|:--------:|
| cloud_provider                 | Cloud provider to deploy the environment (`AWS`, `AZURE`, or `GCP`)         | `string` | n/a              | yes   |
| cloud_region                   | Cloud region for the environment                                            | `string` | n/a              | yes   |
| environment_name               | Environment name (`dev`, `test`, or `prod`)                                 | `string` | n/a              | yes   |
| environment_number                 | Integer suffix used to uniquely identify the environment (1–99)             | `number` | n/a              | yes   |
| stream_governance_package      | Stream Governance package (`ESSENTIALS` or `ADVANCED`)                     | `string` | `"ESSENTIALS"`   | no    |
| module_repo_version_tag        | Version tag of the module being used                                        