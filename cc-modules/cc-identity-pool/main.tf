locals {
  app_config = yamldecode(file(var.app_resources_path))

  identity_pool             = local.app_config.identity_pool
  identity_pool_name        = local.identity_pool.name
  identity_pool_description = try(local.identity_pool.description, "")
  identity_provider         = local.identity_pool.identity_provider
  identity_claim            = local.identity_pool.identity_claim
  filter                    = local.identity_pool.filter
}

data "confluent_identity_provider" "identity_provider" {
  display_name = local.identity_provider
}

resource "confluent_identity_pool" "identity_pool" {
  identity_provider {
    id = data.confluent_identity_provider.identity_provider.id
  }
  display_name    = local.identity_pool_name
  description     = local.identity_pool_description
  identity_claim  = local.identity_claim
  filter          = local.filter
}
