output "vpc_network_name" {
  value       = google_compute_network.vpc_network.name
  description = "The name of the VPC network created"
}

output "subnet_id" {
  value       = google_compute_subnetwork.subnet.id
  description = "The ID of the subnet created"
}
