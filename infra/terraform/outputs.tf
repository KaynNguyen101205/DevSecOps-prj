output "registry_endpoint" {
  description = "Local HTTPS endpoint for the registry."
  value       = module.registry.endpoint
}

output "registry_auth_file" {
  description = "Path to the htpasswd credentials file."
  value       = module.registry.auth_file
}

output "registry_ca_file" {
  description = "Path to the CA certificate to trust in clusters."
  value       = module.registry.ca_file
}

output "kubeconfig_path" {
  description = "Path to the kubeconfig created for the Kind cluster."
  value       = module.k8s.kubeconfig_path
}

output "app_endpoint" {
  description = "Local endpoint reserved for the sample application."
  value       = module.k8s.app_endpoint
}

