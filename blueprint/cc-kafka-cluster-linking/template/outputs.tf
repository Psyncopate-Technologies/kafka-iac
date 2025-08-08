output "linker_service_account_name" {
  value       = module.cc-kafka-cluster-linking.linker_service_account_name
  description = "The name of the service account used for the cluster link"
}

output "local_environment_id" {
  value       = module.cc-kafka-cluster-linking.local_environment_id
  description = "Environment ID for the local Kafka cluster"
}

output "remote_environment_id" {
  value       = module.cc-kafka-cluster-linking.remote_environment_id
  description = "Environment ID for the remote Kafka cluster"
}

output "local_rest_endpoint" {
  value       = module.cc-kafka-cluster-linking.local_rest_endpoint
  description = "REST endpoint for the local Kafka cluster"
}

output "remote_bootstrap_endpoint" {
  value       = module.cc-kafka-cluster-linking.remote_bootstrap_endpoint
  description = "Bootstrap endpoint for the remote Kafka cluster"
}

output "local_cluster_rbac_crn" {
  value       = module.cc-kafka-cluster-linking.local_cluster_rbac_crn
  description = "RBAC CRN of the local Kafka cluster"
}
