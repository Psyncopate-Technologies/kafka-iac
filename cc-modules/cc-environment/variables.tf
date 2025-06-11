variable "environment_name" {
  type        = string
  description = "Name of the Confluent Cloud environment"

  validation {
    condition = can(regex("^[a-zA-Z0-9]([a-zA-Z0-9_-]*[a-zA-Z0-9])?$", var.environment_name))
    error_message = "Must start and end with alphanumeric characters, and may contain hyphens and underscores in between."
  }
}

variable "stream_governance_package" {
  type        = string
  description = "stream governance package"
  default     = "ESSENTIALS"

  validation {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.schema_registry_package))
    error_message = "Must be either 'ESSENTIALS' or 'ADVANCED'."
  }
}
