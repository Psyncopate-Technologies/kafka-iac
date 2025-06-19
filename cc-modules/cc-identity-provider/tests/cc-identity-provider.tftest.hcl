mock_provider "confluent" {
}

variables {
  display_name = "entra-eastus2-01"
  issuer       = "https://example.com"
  jwks_uri     = "https://example.com/.well-known/jwks.json"
  description  = "OIDC Identity Provider"
}

# Check if the provider name is valid
run "valid_identity_provider_name" {
  command = plan

  variables {
    display_name = "entra-eastus2-01"
  }

  assert {
    condition     = can(regex("^entra-[a-z0-9]+-01$", var.display_name))
    error_message = "Should match pattern 'entra-<cloud_region>-01'"
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


# Invalid: wrong prefix
run "invalid_idp_prefix" {
  command = plan

  variables {
    display_name = "azure-eastus2-01"
  }

  expect_failures = [ var.display_name ]
}

# Invalid: region capitalized
run "invalid_idp_caps_region" {
  command = plan

  variables {
    display_name = "entra-EastUS2-01"
  }

  expect_failures = [ var.display_name ]
}

# Invalid: no -01 suffix
run "missing_suffix" {
  command = plan

  variables {
    display_name = "entra-eastus2"
  }

  expect_failures = [ var.display_name ]
}

# Invalid: too short
run "invalid_short_name" {
  command = plan

  variables {
    display_name = "entra-e-1"
  }

  expect_failures = [ var.display_name ]
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

# Check if the issuer is missing
run "missing_issuer" {
  command = plan

  variables {
    issuer   = null
    jwks_uri = "https://valid.com/jwks.json"
  }

  expect_failures = [var.issuer]
}

# Check if the jwks is missing
run "missing_jwks" {
  command = plan

  variables {
    issuer   = "https://valid.com"
    jwks_uri = null
  }

  expect_failures = [var.jwks_uri]
}