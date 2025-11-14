locals {
  data_dir = var.data_dir != "" ? var.data_dir : abspath("${path.root}/generated/registry/data")
  auth_dir = var.auth_dir != "" ? var.auth_dir : abspath("${path.root}/generated/registry/auth")
  certs_dir = var.certs_dir != "" ? var.certs_dir : abspath("${path.root}/generated/registry/certs")
}

resource "null_resource" "directories" {
  triggers = {
    data_dir = local.data_dir
    auth_dir = local.auth_dir
    certs_dir = local.certs_dir
  }

  provisioner "local-exec" {
    command = "mkdir -p \"${local.data_dir}\" \"${local.auth_dir}\" \"${local.certs_dir}\""
  }
}

resource "local_file" "htpasswd" {
  filename        = "${local.auth_dir}/htpasswd"
  content         = "${var.username}:${bcrypt(var.password)}"
  file_permission = "0640"

  depends_on = [null_resource.directories]
}

resource "tls_private_key" "registry" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "tls_self_signed_cert" "registry" {
  private_key_pem = tls_private_key.registry.private_key_pem

  subject {
    common_name  = "localhost"
    organization = "DevSecOps Local"
  }

  validity_period_hours = 24 * 365
  allowed_uses = [
    "key_encipherment",
    "digital_signature",
    "server_auth"
  ]

  dns_names = ["localhost", var.registry_name]
  ip_addresses = ["127.0.0.1"]
}

resource "local_file" "certificate" {
  filename        = "${local.certs_dir}/domain.crt"
  content         = tls_self_signed_cert.registry.cert_pem
  file_permission = "0644"

  depends_on = [null_resource.directories]
}

resource "local_file" "certificate_ca" {
  filename        = "${local.certs_dir}/ca.crt"
  content         = tls_self_signed_cert.registry.cert_pem
  file_permission = "0644"

  depends_on = [null_resource.directories]
}

resource "local_sensitive_file" "key" {
  filename         = "${local.certs_dir}/domain.key"
  content          = tls_private_key.registry.private_key_pem
  file_permission  = "0600"
  directory_permission = "0750"

  depends_on = [null_resource.directories]
}

resource "docker_image" "registry" {
  name = "registry:2"
}

resource "docker_container" "registry" {
  name  = var.registry_name
  image = docker_image.registry.image_id

  restart = "unless-stopped"
  must_run = true

  networks_advanced {
    name    = var.network_name
    aliases = [var.registry_name]
  }

  ports {
    internal = 5000
    external = var.host_port
    ip       = "127.0.0.1"
  }

  mounts {
    type   = "bind"
    target = "/var/lib/registry"
    source = local.data_dir
  }

  mounts {
    type    = "bind"
    target  = "/certs"
    source  = local.certs_dir
    read_only = true
  }

  mounts {
    type    = "bind"
    target  = "/auth"
    source  = local.auth_dir
    read_only = true
  }

  env = [
    "REGISTRY_HTTP_ADDR=0.0.0.0:5000",
    "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt",
    "REGISTRY_HTTP_TLS_KEY=/certs/domain.key",
    "REGISTRY_AUTH=htpasswd",
    "REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd",
    "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm"
  ]

  depends_on = [
    local_file.htpasswd,
    local_file.certificate,
    local_file.certificate_ca,
    local_sensitive_file.key
  ]
}

