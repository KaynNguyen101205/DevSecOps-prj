package terraform.registry

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "docker_container"
  resource.name == "registry"
  after := resource.change.after
  port := after.ports[_]
  not port.ip
  msg := "Registry container port must bind to the loopback interface."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "docker_container"
  resource.name == "registry"
  after := resource.change.after
  port := after.ports[_]
  port.ip != "127.0.0.1"
  msg := sprintf("Registry host IP must be 127.0.0.1 but found %s", [port.ip])
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "docker_container"
  resource.name == "registry"
  after := resource.change.after
  not tls_enabled(after.env)
  msg := "Registry must enable TLS environment variables."
}

deny[msg] {
  resource := input.resource_changes[_]
  resource.type == "docker_network"
  resource.name == "this"
  after := resource.change.after
  options := after.options
  options["com.docker.network.bridge.enable_icc"] != "false"
  msg := "Docker network must disable inter-container communication."
}

tls_enabled(env) {
  env[_] == "REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt"
  env[_] == "REGISTRY_HTTP_TLS_KEY=/certs/domain.key"
}

