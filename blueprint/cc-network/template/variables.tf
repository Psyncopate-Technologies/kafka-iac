# Variables: cc_network module
variable "network_display_name" {
  description = "The name of the Confluent Cloud Network for Azure Private Link."
  type        = string
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

variable "private_link_access_display_name" {
  description = "The name of the Private Link Access entry (allows your subscription to connect)."
  type        = string
}

variable "customer_azure_subscription_id" {
  description = "Your Azure Subscription ID that will be granted Private Link Access."
  type        = string
}

variable "confluent_cloud_environment_name" {
  description = "The name of the Confluent Cloud Environment that the Network belongs to."
  type        = string
}
