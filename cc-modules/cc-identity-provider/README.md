# TF module for CC Identity Provider - Blueprint approach

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement_terraform) | >= 1.9.8 |
| <a name="requirement_confluent"></a> [confluent](#requirement_confluent) | ~> 2.30.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_confluent"></a> [confluent](#provider_confluent) | 2.30.0 |

## Resources

| Name | Type |
|------|------|
| [confluent_identity_provider.this](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/identity_provider) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_display_name"></a> [display_name](#input_display_name) | Human-readable name for the identity provider. | `string` | n/a | ✅ yes |
| <a name="input_issuer"></a> [issuer](#input_issuer) | A valid HTTPS OIDC Issuer URI. | `string` | n/a | ✅ yes |
| <a name="input_jwks_uri"></a> [jwks_uri](#input_jwks_uri) | JWKS URI that returns a JSON Web Key Set. Must use HTTPS. | `string` | n/a | ✅ yes |
| <a name="input_description"></a> [description](#input_description) | Optional description of the identity provider. | `string` | `""` | ❌ no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_identity_provider_id"></a> [identity_provider_id](#output_identity_provider_id) | The ID of the Confluent Cloud identity provider |
| <a name="output_display_name"></a> [display_name](#output_display_name) | The display name of the identity provider |
<!-- END_TF_DOCS -->
