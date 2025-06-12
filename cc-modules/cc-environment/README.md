# TF module for CC Environment and Schema Registry - Blueprint approach

# Confluent Cloud Environment Terraform Module

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.5.0 |
| <a name="requirement_confluent"></a> [confluent](#requirement_confluent) | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider_confluent) | 2.30.0 |

## Resources

| Name | Type |
|------|------|
| [confluent_environment.this](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/environment) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| environment_name | Human-readable name for the Environment. Start and end with alphanumeric characters. Can include hyphens and underscores. | `string` | n/a | yes |
| stream_governance_package | Stream Governance package for the environment | `string` | `"ESSENTIALS"` | no |

## Outputs

| Name | Description |
|------|-------------|
| environment_id | The ID of the created Confluent Cloud environment |
<!-- END_TF_DOCS -->
