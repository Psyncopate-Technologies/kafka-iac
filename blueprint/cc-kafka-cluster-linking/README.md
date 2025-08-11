# Blueprint - Confluent Cloud Kafka Cluster
This blueprint is for a Confluent Cloud Kafka Cluster

## Setup
1. Copy the files from the template folder to a new folder
2. Update the `module_repo_version_tag` in the `main.tf` file
3. Create a `terraform.tfvars` file with your configuration (reference in `test/test.tfvars`)
4. Setup your `provider.tf` file

## Examples

### terraform.tfvars

```hcl
confluent_cloud_api_key     = "********"
confluent_cloud_api_secret  = "********"

link_name                   = "GCP.DEV.MAL.TOPIC"
local_environment_name  = "dev-env"
remote_environment_name = "prod-env"

local_kafka_cluster_name  = "dev-kafka-cluster"
remote_kafka_cluster_name = "prod-kafka-cluster
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_confluent_cloud_api_key"></a> [confluent\_cloud\_api\_key](#input\_confluent\_cloud\_api\_key) | Confluent Cloud API Key (Org Admin) | `string` | n/a | yes |
| <a name="input_confluent_cloud_api_secret"></a> [confluent\_cloud\_api\_secret](#input\_confluent\_cloud\_api\_secret) | Confluent Cloud API Secret (Org Admin) | `string` | n/a | yes |
| <a name="input_link_name"></a> [link\_name](#input\_link\_name) | Cluster link name (e.g., GCP.DEV.MAL.TOPIC) | `string` | `"GCP.DEV.MAL.TOPIC"` | no |
| <a name="input_linker_service_account_name"></a> [linker\_service\_account\_name](#input\_linker\_service\_account\_name) | Service account name for cluster linking | `string` | `"poc-cluster-linker"` | no |
| <a name="input_local_environment_name"></a> [local\_environment\_name](#input\_local\_environment\_name) | Display name of the local environment | `string` | n/a | yes |
| <a name="input_local_kafka_cluster_name"></a> [local\_kafka\_cluster\_name](#input\_local\_kafka\_cluster\_name) | Display name of the local Kafka cluster | `string` | n/a | yes |
| <a name="input_remote_environment_name"></a> [remote\_environment\_name](#input\_remote\_environment\_name) | Display name of the remote environment | `string` | n/a | yes |
| <a name="input_remote_kafka_cluster_name"></a> [remote\_kafka\_cluster\_name](#input\_remote\_kafka\_cluster\_name) | Display name of the remote Kafka cluster | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_linker_service_account_name"></a> [linker\_service\_account\_name](#output\_linker\_service\_account\_name) | The name of the service account used for the cluster link |
| <a name="output_local_cluster_rbac_crn"></a> [local\_cluster\_rbac\_crn](#output\_local\_cluster\_rbac\_crn) | RBAC CRN of the local Kafka cluster |
| <a name="output_local_environment_id"></a> [local\_environment\_id](#output\_local\_environment\_id) | Environment ID for the local Kafka cluster |
| <a name="output_local_rest_endpoint"></a> [local\_rest\_endpoint](#output\_local\_rest\_endpoint) | REST endpoint for the local Kafka cluster |
| <a name="output_remote_bootstrap_endpoint"></a> [remote\_bootstrap\_endpoint](#output\_remote\_bootstrap\_endpoint) | Bootstrap endpoint for the remote Kafka cluster |
| <a name="output_remote_environment_id"></a> [remote\_environment\_id](#output\_remote\_environment\_id) | Environment ID for the remote Kafka cluster |
