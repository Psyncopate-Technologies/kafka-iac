output "cluster_link_id" {
  value       = confluent_cluster_link.this.id
  description = "ID of the created cluster link"
}

output "link_name" {
  value       = confluent_cluster_link.this.link_name
  description = "Name of the cluster link"
}