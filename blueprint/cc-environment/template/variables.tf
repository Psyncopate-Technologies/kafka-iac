variable "environment_name" {
  type        = string
  description = "Name of the Confluent Cloud environment"
}

variable "stream_governance_package" {
  type        = string
  description = "stream governance package"
  default     = "ESSENTIALS"
}

variable "module_repo_version_tag" {
  type        = string
  description = "Version tag of the cc-environment module used in this run"
}