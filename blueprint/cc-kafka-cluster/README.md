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
confluent_cloud_environment_name = "azu-env-d-eastus2-01"
confluent_cloud_network_name     = "azu-net-d-eastus2-01"

cloud_provider = "AZURE"
cloud_region   = "eastus2"

environment_name = "dev"

cluster_number               = 1
cluster_multi_zone_available = false
cluster_ckus                 = 1
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
## Variables for Confluent Cloud Kafka Cluster

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| input_cloud_provider | Cloud provider to deploy Kafka cluster to | `string` | n/a | yes |
| input_cloud_region | Cloud region of the cluster in the specified cloud provider | `string` | n/a | yes |
| input_cluster_ckus | The number of Confluent Kafka Units (CKUs) to allocate to the cluster for cluster scale | `number` | n/a | yes |
| input_cluster_multi_zone_available | The availability zone configuration of the Kafka cluster | `bool` | n/a | yes |
| input_cluster_number | Monotonically increasing integer used as a suffix for cluster name, 1 <= cluster\_number <= 99 | `number` | n/a | yes |
| input_confluent_cloud_environment_name | Confluent Cloud environment name for the environment that the cluster belongs to | `string` | n/a | yes |
| input_confluent_cloud_network_name | Confluent Cloud network name for the network that the cluster uses | `string` | n/a | yes |
| input_environment_name | Deployment environment of cluster: 'dev', 'test', or 'prod' | `string` | n/a | yes |