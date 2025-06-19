# Variables: Confluent Provider
variable "confluent_cloud_api_key" {
  description = "Confluent Cloud API Key for authentication."
  type        = string
  sensitive   = true
}

variable "confluent_cloud_api_secret" {
  description = "Confluent Cloud API Secret for authentication."
  type        = string
  sensitive   = true
}

# Variables: confluent_network resource
variable "network_display_name" {
  description = "The name of the Confluent Cloud Network for Azure Private Link."
  type        = string
  validation {
    condition     = can(regex("^${lower(substr(var.cloud_provider, 0, 3))}-net-${lower(var.confluent_cloud_environment_name)}-${var.region}-([1-9][0-9]|0[1-9])$", var.network_display_name))
    error_message = "confluent_cloud_network_name must follow the CCOE Confluent network naming convention. example: 'azu-net-dev-eastus2-01'"
  }
}

variable "cloud_provider" {
  type        = string
  description = "Cloud provider to deploy Kafka cluster to"
  default = "AZURE"

  validation {
    condition     = contains(["AWS", "AZURE", "GCP"], upper(var.cloud_provider))
    error_message = "cloud_provider must be one of: AWS, AZURE, or GCP"
  }
}

variable "region" {
  description = "The Azure region where the network will exist (e.g., 'eastus', 'centralus')."
  type        = string
}

variable "private_link_dns_resolution" {
  description = "Network DNS resolution for PrivateLink. Can be 'CHASED_PRIVATE' or 'PRIVATE'."
  type        = string
  default     = "PRIVATE" # Recommended for PrivateLink for simpler DNS setup
  validation {
    condition     = contains(["CHASED_PRIVATE", "PRIVATE"], upper(var.private_link_dns_resolution))
    error_message = "Private Link DNS resolution must be 'CHASED_PRIVATE' or 'PRIVATE'."
  }
}

# Variables: confluent_private_link_access resource
variable "private_link_access_display_name" {
  description = "The name of the Private Link Access entry (allows your subscription to connect)."
  type        = string

  validation {
    condition     = can(regex("^${lower(substr(var.cloud_provider, 0, 3))}-pla-${lower(var.confluent_cloud_environment_name)}-${var.region}-([1-9][0-9]|0[1-9])$", var.private_link_access_display_name))
    error_message = "confluent_cloud_network_name must follow the CCOE Confluent network Private Link Access naming convention. example: 'azu-pla-dev-eastus2-01'"
  }
}

variable "customer_azure_subscription_id" {
  description = "Your Azure Subscription ID that will be granted Private Link Access."
  type        = string

  validation {
    condition     = can(regex("^[0-9A-Fa-f]{8}-([0-9A-Fa-f]{4}-){3}[0-9A-Fa-f]{12}$", var.customer_azure_subscription_id))
    error_message = "The Azure Subscription ID must be a valid GUID (e.g., xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx)."
  }
}

# Variables: confluent_environment data
variable "confluent_cloud_environment_name" {
  description = "The name of the Confluent Cloud Environment that the Network belongs to."
  type        = string
}