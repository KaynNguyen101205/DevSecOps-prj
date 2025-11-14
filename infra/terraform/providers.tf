terraform {
  required_version = ">= 1.6.0"

  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = ">= 3.0.2"
    }

    kind = {
      source  = "tehcyx/kind"
      version = ">= 0.5.0"
    }

    local = {
      source  = "hashicorp/local"
      version = ">= 2.4.0"
    }

    random = {
      source  = "hashicorp/random"
      version = ">= 3.5.1"
    }

    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.5"
    }
  }
}

provider "docker" {}

provider "kind" {}

