# Data: confluent_environment
# This resource provides information about the Confluent Cloud Environment that the Network belongs to
data "confluent_environment" "cc_environment" {
  display_name = var.confluent_cloud_environment_name
}