variable "network_name" {
  description = "Docker network that the registry joins."
  type        = string
}

variable "registry_name" {
  description = "Name assigned to the registry container."
  type        = string
}

variable "host_port" {
  description = "Host port exposed for the registry."
  type        = number
}

variable "username" {
  description = "Registry username."
  type        = string
}

variable "password" {
  description = "Registry password."
  type        = string
  sensitive   = true
}

variable "data_dir" {
  description = "Directory for persistent registry data."
  type        = string
  default     = ""
}

variable "auth_dir" {
  description = "Directory for htpasswd files."
  type        = string
  default     = ""
}

variable "certs_dir" {
  description = "Directory for TLS certificate and key."
  type        = string
  default     = ""
}

