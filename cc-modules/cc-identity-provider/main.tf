resource "confluent_identity_provider" "this" {
  display_name = var.display_name
  issuer       = var.issuer
  jwks_uri     = var.jwks_uri
  description  = var.description

  lifecycle {
    prevent_destroy = true
  }
}

