terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.5.1"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.11.0"
    }

    kubectl = {
      source  = "gavinbunney/kubectl"
      version = ">= 1.7.0"
    }
  }
}
