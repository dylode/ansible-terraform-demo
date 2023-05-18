terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.28.1"
    }
    ansible = {
      version = "1.1.0"
      source  = "ansible/ansible"
    }
  }
}

provider "digitalocean" {
  token = "xxx"
}
