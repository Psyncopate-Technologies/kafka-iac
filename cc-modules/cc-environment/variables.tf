variable "environment_name" {
  type        = string
  description = "Name of the Confluent Cloud environment"

  validation {
    condition = (
      contains(["np", "nonprod", "p", "prod", "t", "test", "d", "dev"], lower(var.environment_name))
      && length(var.environment_name) <= 4
    )
    error_message = "The 'environment_name' must be one of: np, nonprod, p, prod, t, test, d, dev and must not exceed 4 characters."
  }
}

variable "stream_governance_package" {
  type        = string
  description = "stream governance package"
  default     = "ESSENTIALS"

  validation {
    condition     = contains(["ESSENTIALS", "ADVANCED"], upper(var.stream_governance_package))
    error_message = "Must be either 'ESSENTIALS' or 'ADVANCED'."
  }
}

variable "module_repo_version_tag" {
  type        = string
  description = "Version tag of the cc-environment module used in this run"
  default     = "latest"
}