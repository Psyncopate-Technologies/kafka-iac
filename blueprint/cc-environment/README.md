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
environment_name          = "dev-team1"
stream_governance_package = "ESSENTIALS"
