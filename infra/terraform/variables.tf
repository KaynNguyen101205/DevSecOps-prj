variable "network_name" {
  description = "Name for the Docker network that isolates DevSecOps resources."
  type        = string
  default     = "devsecops_net"
}

variable "network_subnet" {
  description = "CIDR block used by the Docker network."
  type        = string
  default     = "10.11.0.0/16"
}

variable "network_gateway" {
  description = "Gateway IP address for the Docker network."
  type        = string
  default     = "10.11.0.1"
}

variable "registry_name" {
  description = "Container name for the local registry."
  type        = string
  default     = "devsecops-registry"
}

variable "registry_host_port" {
  description = "Host port that maps to the registry service."
  type        = number
  default     = 5001
}

variable "registry_username" {
  description = "Username used to authenticate with the registry."
  type        = string
  default     = "registryuser"
}

variable "registry_password" {
  description = "Password used to authenticate with the registry."
  type        = string
  sensitive   = true
  default     = "changeMe123!"
}

variable "registry_data_dir" {
  description = "Host path used to persist registry data."
  type        = string
  default     = ""
}

variable "registry_auth_dir" {
  description = "Host path used to store htpasswd credentials."
  type        = string
  default     = ""
}

variable "registry_certs_dir" {
  description = "Host path used to store registry TLS certificates."
  type        = string
  default     = ""
}

variable "cluster_name" {
  description = "Name of the Kind cluster."
  type        = string
  default     = "devsecops-cluster"
}

variable "kind_node_image" {
  description = "Kind node image."
  type        = string
  default     = "kindest/node:v1.29.2"
}

variable "kind_worker_count" {
  description = "Number of worker nodes to add to the Kind cluster."
  type        = number
  default     = 1
}

variable "app_host_port" {
  description = "Host port exposed for the sample application NodePort service."
  type        = number
  default     = 30007
}

variable "kubeconfig_path" {
  description = "Absolute path where the kubeconfig file should be written."
  type        = string
  default     = ""
}

