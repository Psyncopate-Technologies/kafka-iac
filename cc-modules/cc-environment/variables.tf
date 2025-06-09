variable "environment_name" {
  type        = string
  description = "Name of the Confluent Cloud environment"

  validation {
    condition = (
      length(var.environment_name) <= 100 &&
      can(regex("^[a-z][a-z0-9-]{0,99}$", var.environment_name))
    )
    error_message = "Must be ≤100 characters, lowercase alphanumeric with dashes, and start with a lowercase letter."
  }
}

variable "schema_registry_package" {
  type        = string
  description = "Schema Registry package"

  validation {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.schema_registry_package))
    error_message = "Must be either 'ESSENTIALS' or 'ADVANCED'."
  }
}
