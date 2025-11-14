locals {
  kubeconfig_path        = var.kubeconfig_path != "" ? var.kubeconfig_path : abspath("${path.root}/kubeconfig")
  containerd_certs_dir   = "/etc/containerd/certs.d/${var.registry_alias}:5000"
}

resource "kind_cluster" "this" {
  name       = var.cluster_name
  node_image = var.node_image
  wait_for_ready = true
  log_level  = "info"
  network    = var.network_name

  kubeconfig {
    path    = local.kubeconfig_path
    context = var.cluster_name
  }

  kind_config {
    kind        = "Cluster"
    api_version = "kind.x-k8s.io/v1alpha4"

    networking {
      disable_default_cni = false
      pod_subnet          = "10.244.0.0/16"
      service_subnet      = "10.96.0.0/12"
    }

    nodes {
      role = "control-plane"

      extra_port_mappings {
        container_port = 30007
        host_port      = var.app_host_port
        listen_address = "127.0.0.1"
        protocol       = "TCP"
      }

      extra_mounts {
        host_path      = var.registry_cert_dir
        container_path = local.containerd_certs_dir
        read_only      = true
      }
    }

    dynamic "nodes" {
      for_each = var.worker_count > 0 ? range(var.worker_count) : []

      content {
        role = "worker"

        extra_mounts {
          host_path      = var.registry_cert_dir
          container_path = local.containerd_certs_dir
          read_only      = true
        }
      }
    }

    containerd_config_patches = [
      <<-EOT
      [plugins."io.containerd.grpc.v1.cri".registry.mirrors."${var.registry_host_endpoint}"]
        endpoint = ["https://${var.registry_alias}:5000"]
      [plugins."io.containerd.grpc.v1.cri".registry.configs."${var.registry_alias}:5000".tls]
        ca_file = "${local.containerd_certs_dir}/ca.crt"
      EOT
    ]
  }
}

resource "null_resource" "kubeconfig_permissions" {
  triggers = {
    kubeconfig = local.kubeconfig_path
    cluster_id = kind_cluster.this.id
  }

  provisioner "local-exec" {
    command = "chmod 600 \"${local.kubeconfig_path}\""
  }
}

