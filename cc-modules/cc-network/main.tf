# Resource: confluent_network
# This resource creates a Confluent Cloud Network configured for PrivateLink.
resource "confluent_network" "private-link" {
  display_name     = var.network_display_name
  cloud            = "AZURE"
  region           = var.region
  connection_types = ["PRIVATELINK"]

  dns_config {
    resolution = var.private_link_dns_resolution
  }

  # Environment association is mandatory
  environment {
    id = data.confluent_environment.cc_environment.id
  }

  # Recommended: Prevent accidental deletion in production
  lifecycle {
    prevent_destroy = true
  }
}

# Resource: confluent_private_link_access
# This resource allows specific Azure subscriptions to auto-approve Private Endpoint connections.
resource "confluent_private_link_access" "azure" {
  display_name = var.private_link_access_display_name

  environment {
    id = data.confluent_environment.cc_environment.id
  }

  network {
    id = confluent_network.private-link.id
  }

  azure {
    subscription = var.customer_azure_subscription_id
  }

  # Recommended: Prevent accidental deletion in production
  lifecycle {
    prevent_destroy = true
  }
}