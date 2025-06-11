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