resource "confluent_environment" "this" {
  display_name = var.confluent_cloud_environment_name

  stream_governance {
    package = var.stream_governance_package
  }

  lifecycle {
    prevent_destroy = true
  }
}