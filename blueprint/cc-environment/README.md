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

## Variables for Confluent Cloud environment and Schema Registry

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| module_repo_version_tag | Repo version tag of module, such as 'v1.0.0' | `string` | latest | yes |
| environment_name | Valid values are (single/shortname/name): Np/p/prod/T/test/D/dev | `string` | n/a | yes |
| stream_governance_package | Stream Governance package for the environment | `string` | `"ESSENTIALS"` | no |