variable "network_name" {
  description = "Docker network that Kind should join."
  type        = string
}

variable "cluster_name" {
  description = "Name of the Kind cluster."
  type        = string
}

variable "node_image" {
  description = "Kind node image version."
  type        = string
}

variable "worker_count" {
  description = "Number of worker nodes."
  type        = number
}

variable "registry_alias" {
  description = "Docker network alias for the registry."
  type        = string
}

variable "registry_host_endpoint" {
  description = "Host endpoint that resolves to the registry (used by developer tools)."
  type        = string
}

variable "registry_cert_dir" {
  description = "Directory that holds registry TLS files."
  type        = string
}

variable "app_host_port" {
  description = "Host port to forward to NodePort service."
  type        = number
}

variable "kubeconfig_path" {
  description = "Absolute path where the kubeconfig should be written."
  type        = string
}

