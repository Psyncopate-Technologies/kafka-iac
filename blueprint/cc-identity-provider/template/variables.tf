variable "display_name" {
  type        = string
  description = "Name of the Identity Provider"

  validation {
    condition     = length(var.display_name) > 0 && length(var.display_name) <= 100
    error_message = "Display name must be non-empty and no more than 100 characters."
  }
}

variable "issuer" {
  type        = string
  description = "Issuer URI (OIDC issuer)"

  validation {
    condition     = can(regex("^https://", var.issuer))
    error_message = "Issuer must be a valid HTTPS URI."
  }
}

variable "jwks_uri" {
  type        = string
  description = "A publicly reachable JWKS URI. Must start with 'https://'"

  validation {
    condition     = can(regex("^https://.+", var.jwks_uri))
    error_message = "The JWKS URI must be a valid HTTPS URI."
  }
}

variable "description" {
  type        = string
  description = "Optional description"
  default     = null

  validation {
    condition     = var.description == null || length(var.description) <= 256
    error_message = "Description must be at most 256 characters."
  }
}

variable "module_repo_version_tag" {
  type        = string
  description = "Version tag of the cc-identity_provider module used in this run"
}