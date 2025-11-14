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

