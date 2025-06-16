mock_provider "confluent" {
  mock_data "confluent_identity_provider" {
    defaults = {
      id          = "idp-abc123"
      display_name = "my-idp"
      issuer      = "https://example.com"
      jwks_uri    = "https://example.com/.well-known/jwks.json"
      description = "OIDC Identity Provider"
    }
  }
}

variables {
  display_name = "my-idp"
  issuer       = "https://example.com"
  jwks_uri     = "https://example.com/.well-known/jwks.json"
  description  = "OIDC Identity Provider"
}

# Check if identity provider name is set correctly
run "idp_display_name_check" {
  command = plan

  assert {
    condition     = confluent_identity_provider.this.display_name == "my-idp"
    error_message = "Display name must be 'my-idp'"
  }
}

# Check if issuer URL is configured correctly
run "idp_issuer_check" {
  command = plan

  assert {
    condition     = confluent_identity_provider.this.issuer == "https://example.com"
    error_message = "Issuer must be 'https://example.com'"
  }
}

# Check if JWKS URI is valid and set
run "idp_jwks_uri_check" {
  command = plan

  assert {
    condition     = startswith(confluent_identity_provider.this.jwks_uri, "https://")
    error_message = "JWKS URI must start with https://"
  }
}

# Check that description is correctly assigned
run "idp_description_check" {
  command = plan

  assert {
    condition     = confluent_identity_provider.this.description == "OIDC Identity Provider"
    error_message = "Description must be 'OIDC Identity Provider'"
  }
}

# Invalid JWKS URI
run "invalid_jwks_uri" {
  command = plan

  variables {
    jwks_uri = "not-a-valid-uri"
  }

  expect_failures = [var.jwks_uri]
}

# Invalid issuer (not a URI)
run "invalid_issuer" {
  command = plan

  variables {
    issuer = "invalid_issuer"
  }

  expect_failures = [var.issuer]
}

run "missing_issuer" {
  command = plan

  variables {
    issuer   = null
    jwks_uri = "https://valid.com/jwks.json"
  }

  expect_failures = [var.issuer]
}

run "missing_jwks" {
  command = plan

  variables {
    issuer   = "https://valid.com"
    jwks_uri = null
  }

  expect_failures = [var.jwks_uri]
}
