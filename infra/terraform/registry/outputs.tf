output "endpoint" {
  description = "Registry endpoint reachable from the host."
  value       = "https://localhost:${var.host_port}"
}

output "container_name" {
  description = "Registry container name."
  value       = docker_container.registry.name
}

output "network_alias" {
  description = "Name other containers can use to reach the registry on the Docker network."
  value       = var.registry_name
}

output "auth_file" {
  description = "Path to the htpasswd file."
  value       = local_file.htpasswd.filename
}

output "certificate_file" {
  description = "Path to the registry certificate."
  value       = local_file.certificate.filename
}

output "certificate_directory" {
  description = "Directory that stores the registry TLS material."
  value       = local.certs_dir
}

output "ca_file" {
  description = "Path to the CA certificate file."
  value       = local_file.certificate_ca.filename
}

