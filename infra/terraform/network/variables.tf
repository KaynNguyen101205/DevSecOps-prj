variable "network_name" {
  description = "Name for the Docker network."
  type        = string
}

variable "subnet" {
  description = "CIDR block assigned to the Docker network."
  type        = string
}

variable "gateway" {
  description = "Gateway IP for the Docker network."
  type        = string
}

