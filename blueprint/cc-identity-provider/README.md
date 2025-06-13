# Blueprint - Confluent Cloud Identity Provider

This blueprint provisions a Confluent Cloud Identity Provider using the `confluent_identity_provider` resource.

## Setup

1. Copy the files from `template/test/` into your environment-specific repo.
2. Update module_repo_version_tag in the main.tf
3. Create a test.tfvars file with your configuration
4. Add your provider.tf for the Confluent Cloud provider authentication


## Example test.tfvars

```hcl
display_name = "AzureAD-SSO"
description  = "OIDC integration with AzureAD"
issuer       = "https://login.microsoftonline.com/<tenant-id>/v2.0"
jwks_uri     = "https://login.microsoftonline.com/<tenant-id>/discovery/v2.0/keys"
