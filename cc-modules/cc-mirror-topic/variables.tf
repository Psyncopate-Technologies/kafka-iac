variable "mirror_topics_yaml_file" {
  type        = string
  description = "Path to the YAML file containing mirror topic specifications"
}
variable "mirror_topic_config_raw" {
  type        = string
  description = "Raw YAML string defining mirror topic configuration."
}

variable "delete_after_migration" {
  description = "If true, mirror topic will not be created (count=0) and destroy will be allowed"
  type        = bool
  default     = false
}

variable "mirror_topic_status" {
  description = "Mirror topic status: ACTIVE, PAUSED, PROMOTED, or FAILED_OVER"
  type        = string
  default     = "ACTIVE"
}

variable "cluster_link_name" {
  description = "Name of the cluster link used for mirroring"
  type        = string
}

variable "mirror_topic_name" {
  type        = string
  description = "Name of the mirror topic"
}

variable "target_env_name" {
  type        = string
  description = "Target environment name"
}

variable "target_cluster_name" {
  type        = string
  description = "Target cluster name"
}

variable "source_topic_name" {
  type        = string
  description = "Source topic name"
}
