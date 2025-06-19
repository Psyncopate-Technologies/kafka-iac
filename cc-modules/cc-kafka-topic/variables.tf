variable "topic_path" {
  type        = string
  description = "Absolute path to the YAML file defining the topic configuration (must be a single-topic YAML)."
  nullable    = false
  validation {
    condition     = can(regex("\\.ya?ml$", var.topic_path))
    error_message = "topic_path must point to a .yaml or .yml file."
  }
}

variable "topic_config_raw" {
  description = "Parsed topic configuration from YAML file."
  type        = any
  nullable    = false

  validation {
    condition     = length(keys(var.topic_config_raw)) > 0
    error_message = "topic_config_raw must be a non-empty object."
  }
}

variable "topic_name" {
  type        = string
  description = "The name of the topic to be created. This is used to validate the naming convention of the topic."
  nullable    = false
  validation {
    condition = length(var.topic_name) > 0 && can(
      regex(
        "^[A-Z]{3}\\.(DEV[1-4]|TEST[1-4]|PROD)\\.[A-Z0-9]{2,}\\.[A-Za-z0-9]+\\.[A-Za-z0-9]+\\.(JSON|AVRO|STRING)\\.(CDO\\.EVENT|SPECIFIC\\.EVENT|RAW\\.EVENT|COMMAND|API\\.REQUEST|API\\.RESPONSE|STREAM\\.REQUEST|STREAM\\.RESPONSE|PRIVATE|DEADLETTER)$",
        var.topic_name
      )
    )
    error_message = "The topic_name must follow the format:DataCenter.Environment.MAL.EnterpriseTaxonomy.CapabilityTaxonomy.Format.MessagePattern : Example: GCP.DEV1.CLMAL1.CustomerData.Consent.JSON.CDO.EVENT"
  }
}

variable "default_partitions" {
  type        = number
  description = "Default number of partitions for the topic if not specified in the YAML file. The default value here will be overridden from terragrunt based on environment."
  default     = 3 # Optional: Terragrunt will override this
}

variable "create_mal_tag" {
  type        = bool
  description = "Should Client MAL tag be created? This is used to create a tag for the topic if it does not already exist."
  default     = false
}

variable "create_srb_tag" {
  type        = bool
  description = "Should Client SRB Review # tag be created? This is used to create a tag for the topic if it does not already exist."
  default     = false
}
