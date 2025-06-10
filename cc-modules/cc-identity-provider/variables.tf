variable "display_name" {
  type        = string
  description = "Name of the Identity Provider"
}

variable "issuer" {
  type        = string
  description = "Issuer URI (OIDC issuer)"
  
}

variable "jwks_uri" {
  type        = string
  description = "JWKS URI (required for OIDC)"
}


variable "description" {
  type        = string
  description = "Optional description"
  default     = null
}


variable "kafka_api_key" {
  type        = string
  description = "Kafka API key for authenticating with the Kafka REST API."
  sensitive   = true
}

variable "kafka_api_secret" {
  type        = string
  description = "Kafka API secret for the Kafka REST API."
  sensitive   = true
}
