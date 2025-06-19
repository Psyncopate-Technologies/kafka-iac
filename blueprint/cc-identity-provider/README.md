# Blueprint - Confluent Cloud Identity Provider

This blueprint provisions a Confluent Cloud Identity Provider using the `confluent_identity_provider` resource.

## Setup

1. Copy the files from `template/` into your environment-specific repo.
2. Update module_repo_version_tag in the main.tf
3. Create a test.tfvars file with your configuration
4. Add your provider.tf for the Confluent Cloud provider authentication


## Example test.tfvars

```hcl
display_name = "AzureAD-SSO"
description  = "OIDC integration with AzureAD"
issuer       = "https://login.microsoftonline.com/<tenant-id>/v2.0"
jwks_uri     = "https://login.microsoftonline.com/<tenant-id>/discovery/v2.0/keys"

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

## Variables for Confluent Cloud Identity Provider

| Name                   | Description                                                                                  | Type     | Default | Required |
|------------------------|----------------------------------------------------------------------------------------------|----------|---------|:--------:|
| module_repo_version_tag| Repo version tag of module, such as `'v1.0.0'`                                               | `string` | latest  |  Yes   |
| display_name           | Name of the identity provider. Must follow format: `entra-<region>-01`                      | `string` | n/a     |  Yes   |
| issuer                 | The Issuer URI for the identity provider (must be a valid HTTPS URL)                        | `string` | n/a     |  Yes   |
| jwks_uri               | The JWKS URI used to verify the provider's JWT tokens (must be a valid HTTPS URL)           | `string` | n/a     |  Yes   |
| description            | Optional description for the identity provider                                               | `string` | `""`    |  No    |
