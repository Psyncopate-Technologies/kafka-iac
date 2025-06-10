# Logic for topics
include {
  path = find_in_parent_folders("_common/common.hcl")
}

locals {
  cloud_provider = get_env("CLOUD_PROVIDER", "azure")
  env            = get_env("ENV", "dev")
  topic_path     = "${get_terragrunt_dir()}/${get_env("FILE_NAME")}"
  

  # Parse topic name from YAML (assumes only one topic)
  topic_config_raw = yamldecode(file(local.topic_path))
  topic_name       = local.topic_config_raw.topic.name

  # Retrieve ClientMAL and SRB#
  clientMAL = local.topic_config_raw.topic.mal_acronym
  srb_review_number = local.topic_config_raw.topic.srb_review_number

  # Use pipeline_version if present, otherwise default to "latest"
  iac_version = try(local.topic_config_raw.pipeline_version, "latest")

  # Define environment-specific defaults
  #default_partitions = local.env == "dev" ? 3 : local.env == "test" ? 6 : 6
  default_partitions = get_env("DEFAULT_PATITION_COUNT")

  # Conditionally create the backend config block
  backend_config = (
        local.cloud_provider == "azure" ? <<EOF
    terraform {
    backend "azurerm" {
        resource_group_name  = "${get_env("AZURE_RESOURCE_GROUP_NAME", "psy-flink-poc")}"
        storage_account_name = "${get_env("AZURE_STORAGE_ACCOUNT_NAME", "psyflinkops")}"
        container_name       = "${get_env("AZURE_STORAGE_CONTAINER_NAME", "psyflinkcontainer")}"
        key                  = "${local.env}/topics/${local.topic_config_raw.topic.alias_name}.tfstate"
    }
    }
    EOF
        : local.cloud_provider == "aws" ? <<EOF
    terraform {
    backend "s3" {
        bucket         = "${get_env("AWS_BACKEND_BUCKET_NAME", "my-terraform-state")}"
        key            = "${local.env}/topics/${local.topic_config_raw.topic.alias_name}.tfstate"
        region         = "${get_env("AWS_REGION", "us-east-1")}"
        dynamodb_table = "${get_env("AWS_DYNAMODB_TABLE_NAME", "terraform-locks")}"
        encrypt        = true
    }
    }
    EOF
        : local.cloud_provider == "gcp" ? <<EOF
    terraform {
    backend "gcs" {
        bucket = "${get_env("GCP_BACKEND_BUCKET_NAME", "my-terraform-state")}"
        prefix = "${local.env}/topics/${local.topic_config_raw.topic.alias_name}"
    }
    }
    EOF
        : error("Unsupported cloud_provider: ${local.cloud_provider}")
    )
}

terraform {
  source = "git::https://${get_env("GITHUB_TOKEN")}@github.com/Psyncopate-Technologies/kafka-iac.git//cc-modules/cc-kafka-topic?ref=${local.iac_version}"

  before_hook "check_tag_existence" {
    commands = ["plan", "apply"]
    execute  = [
      "${get_terragrunt_dir()}/validation/check_tag_existence.sh",
      get_env("CC_SR_API_KEY"),
      get_env("CC_SR_API_SECRET"),
      get_env("CC_SR_ENDPOINT"),
      local.clientMAL,
      local.srb_review_number
    ]
  }
  
}

inputs = {
# From common.hcl    
#   confluent_api_key    = get_env("CONFLUENT_API_KEY")
#   confluent_api_secret = get_env("CONFLUENT_API_SECRET")
#   kafka_api_key        = get_env("KAFKA_API_KEY")
#   kafka_api_secret     = get_env("KAFKA_API_SECRET")
#   kafka_cluster_id     = get_env("KAFKA_CLUSTER_ID")
#   kafka_rest_endpoint  = get_env("KAFKA_REST_ENDPOINT")
  topic_path           = local.topic_path
  topic_name           = local.topic_name # Explicitly passing this as input so as to validate the naming convention of it in variables.tf
  default_partitions   = local.default_partitions
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite"
  contents  = <<EOF
provider "confluent" {
  cloud_api_key    = var.confluent_api_key
  cloud_api_secret = var.confluent_api_secret
}
EOF
}

generate "backend" {
  path      = "backend.tf"
  if_exists = "overwrite"
  contents  = local.backend_config
}

generate "outputs" {
  path      = "outputs.tf"
  if_exists = "overwrite"
  contents  = <<EOF
output "pipeline_version" {
  value       = "${local.iac_version}"
  description = "The version of the IaC module that was applied."
}
output "topic_id" {
  value = confluent_kafka_topic.cc_kafka_topic.id
}
EOF
}

