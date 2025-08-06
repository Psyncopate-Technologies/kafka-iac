output "linker_service_account_name" {
  value       = local.linker_sa_name
  description = "The name of the service account used for the cluster link"
}

output "local_environment_id" {
  value       = local.local_environment_id
  description = "Environment ID for the local Kafka cluster"
}

output "remote_environment_id" {
  value       = local.remote_environment_id
  description = "Environment ID for the remote Kafka cluster"
}

output "local_rest_endpoint" {
  value       = local.local_rest_endpoint
  description = "REST endpoint for the local Kafka cluster"
}

output "remote_bootstrap_endpoint" {
  value       = local.remote_bootstrap_endpoint
  description = "Bootstrap endpoint for the remote Kafka cluster"
}

output "local_cluster_rbac_crn" {
  value       = local.local_cluster_rbac_crn
  description = "RBAC CRN of the local Kafka cluster"
}
