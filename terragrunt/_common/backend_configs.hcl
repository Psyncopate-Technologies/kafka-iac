locals {
  backend_common = {
    azure = {
      template = <<EOF
terraform {
  backend "azurerm" {
    resource_group_name  = "${get_env("AZURE_RESOURCE_GROUP_NAME", "enterprise-kafka-rg")}"
    storage_account_name = "${get_env("AZURE_STORAGE_ACCOUNT_NAME", "enterprise-kafka-sa")}"
    container_name       = "${get_env("AZURE_STORAGE_CONTAINER_NAME", "enterprise-kafka-container")}"
    key                  = "%s"
  }
}
EOF
    }
    aws = {
      template = <<EOF
terraform {
  backend "s3" {
    bucket         = "${get_env("AWS_BACKEND_BUCKET_NAME", "my-terraform-state")}"
    region         = "${get_env("AWS_REGION", "us-east-1")}"
    key            = "%s"
    dynamodb_table = "${get_env("AWS_DYNAMODB_TABLE_NAME", "terraform-locks")}"
    encrypt        = true
  }
}
EOF
    }
    gcp = {
      template = <<EOF
terraform {
  backend "gcs" {
    bucket = "${get_env("GCP_BACKEND_BUCKET_NAME", "my-terraform-state")}"
    prefix = "%s"
  }
}
EOF
    }
    local = {
      template = <<EOF
terraform {
  backend "local" {
    path = "%s"
  }
}
EOF
    }
  }
}
