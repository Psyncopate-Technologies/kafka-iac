variable "link_name" {
  type        = string
  description = "Optional name of the cluster link. If not set, will be generated automatically."
  default     = null
}

variable "link_mode" {
  type        = string
  description = "Link mode: BIDIRECTIONAL or ONE_WAY"
  default     = "BIDIRECTIONAL"
  validation {
    condition     = contains(["BIDIRECTIONAL", "ONE_WAY"], upper(var.link_mode))
    error_message = "link_mode must be either BIDIRECTIONAL or ONE_WAY"
  }
}

variable "local_cluster_id" {
  type        = string
  description = "ID of the local Kafka cluster"
}

variable "local_rest_endpoint" {
  type        = string
  description = "REST endpoint of the local Kafka cluster"
}

variable "local_api_key_id" {
  type        = string
  description = "API Key ID for the local cluster"
}

variable "local_api_key_secret" {
  type        = string
  description = "API Key Secret for the local cluster"
  sensitive   = true
}

variable "remote_cluster_id" {
  type        = string
  description = "ID of the remote Kafka cluster"
}

variable "remote_bootstrap" {
  type        = string
  description = "Bootstrap server of the remote Kafka cluster"
}

variable "remote_api_key_id" {
  type        = string
  description = "API Key ID for the remote cluster"
}

variable "remote_api_key_secret" {
  type        = string
  description = "API Key Secret for the remote cluster"
  sensitive   = true
}
