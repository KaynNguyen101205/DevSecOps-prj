locals {
  registry_host_endpoint = format("localhost:%d", var.registry_host_port)
  kubeconfig_path        = var.kubeconfig_path != "" ? var.kubeconfig_path : abspath("${path.module}/kubeconfig")
}

module "network" {
  source = "./network"

  network_name = var.network_name
  subnet       = var.network_subnet
  gateway      = var.network_gateway
}

module "registry" {
  source = "./registry"

  network_name = module.network.name
  registry_name = var.registry_name
  host_port     = var.registry_host_port
  username      = var.registry_username
  password      = var.registry_password

  data_dir  = var.registry_data_dir
  auth_dir  = var.registry_auth_dir
  certs_dir = var.registry_certs_dir
}

module "k8s" {
  source = "./k8s"

  network_name           = module.network.name
  cluster_name           = var.cluster_name
  node_image             = var.kind_node_image
  worker_count           = var.kind_worker_count
  registry_alias         = module.registry.network_alias
  registry_host_endpoint = local.registry_host_endpoint
  registry_cert_dir      = module.registry.certificate_directory
  app_host_port          = var.app_host_port
  kubeconfig_path        = local.kubeconfig_path

  depends_on = [module.registry]
}

