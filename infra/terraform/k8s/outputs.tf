output "kubeconfig_path" {
  description = "Path to the kubeconfig file for the Kind cluster."
  value       = local.kubeconfig_path
}

output "cluster_name" {
  description = "Name of the Kind cluster."
  value       = var.cluster_name
}

output "app_endpoint" {
  description = "Default localhost endpoint for the sample application."
  value       = "http://localhost:${var.app_host_port}"
}

