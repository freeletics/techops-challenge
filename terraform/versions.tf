terraform {
  required_version = "~> 0.14"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 1.3"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "~> 1.12"
    }

    null = {
      source  = "hashicorp/null"
      version = "~> 2.1"
    }

    sops = {
      source  = "carlpett/sops"
      version = "0.5.2"
    }
  }
}
