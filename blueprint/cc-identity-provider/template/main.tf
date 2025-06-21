module "identity_provider" {
  source = "github.com/Psyncopate-Technologies/kafka-iac//cc-modules/cc-identity-provider?ref=<INSERT module_repo_version_tag VARIABLE HERE>"

  module_repo_version_tag = <INSERT module_repo_version_tag VARIABLE HERE

  display_name = var.display_name
  description  = var.description
  issuer       = var.issuer
  jwks_uri     = var.jwks_uri
}