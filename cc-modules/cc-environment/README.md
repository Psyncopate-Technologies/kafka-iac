# TF module for CC Environment and Schema Registry - Blueprint approach

# Confluent Cloud Environment Terraform Module

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
| [confluent_environment.this](https://registry.terraform.io/providers/confluentinc/confluent/latest/docs/resources/environment) | resource |

## Inputs

| Name                           | Description                                                                 | Type     | Default         | Required |
|--------------------------------|-----------------------------------------------------------------------------|----------|------------------|:--------:|
| module_repo_version_tag        | Repo version tag of the module, e.g. `'v1.0.0'`                             | `string` | `"latest"`       |   yes    |
| cloud_provider                 | Cloud provider to deploy environment (`AWS`, `AZURE`, or `GCP`)             | `string` | n/a              |   yes    |
| cloud_region                   | Cloud region of the environment                                             | `string` | n/a              |   yes    |
| environment_name               | Environment name (`dev`, `test`, `prod`)                                    | `string` | n/a              |   yes    |
| cluster_number                 | Numeric identifier suffix for the environment (1–99)                        | `number` | n/a              |   yes    |
| stream_governance_package      | Stream Governance package (`ESSENTIALS` or `ADVANCED`)                     | `string` | `"ESSENTIALS"`   |   no     |

---

## Outputs

| Name                             | Description                                                                 |
|----------------------------------|-----------------------------------------------------------------------------|
| environment_id                   | The ID of the created Confluent Environment                                 |
| stream_governance_package        | The stream governance package used in the environment                       |
| confluent_cloud_environment_name | Constructed environment name following CCOE naming convention               |
| module_repo_version_tag          | Version tag of the cc-environment module used in this run                   |


