terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.2"
    }
  }
}

resource "docker_network" "this" {
  name   = var.network_name
  driver = "bridge"

  ipam_config {
    subnet  = var.subnet
    gateway = var.gateway
  }

  options = {
    "com.docker.network.bridge.enable_icc"  = "false"
    "com.docker.network.bridge.enable_ip_masquerade" = "true"
  }
}

