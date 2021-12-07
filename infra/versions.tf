terraform {
  required_version = ">= 1.0.11"
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = ">= 2.16.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.4.1"
    }
  }
}