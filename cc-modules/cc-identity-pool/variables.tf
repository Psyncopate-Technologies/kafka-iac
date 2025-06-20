variable "app_resources_path" {
  type        = string
  description = "Absolute path to the YAML file defining the app resources configuration."
  nullable    = false
  # validation {
  #   condition     = can(regex("\\.ya?ml$", var.topic_path))
  #   error_message = "app_resources_path must point to a .yaml or .yml file."
  # }
}