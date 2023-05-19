resource "digitalocean_droplet" "webserver" {
  image    = "debian-11-x64"
  name     = "webserver-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = ["f1:77:5a:66:bf:57:d0:a9:b1:8b:03:e1:7f:35:c8:62"]
  tags     = ["webserver", "monitored"]
  count    = 3
}

resource "digitalocean_droplet" "database" {
  image    = "debian-11-x64"
  name     = "database-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = ["f1:77:5a:66:bf:57:d0:a9:b1:8b:03:e1:7f:35:c8:62"]
  tags     = ["database", "monitored"]
  count    = 1
}

resource "ansible_host" "webserver" {
  for_each = {
    for index, droplet in digitalocean_droplet.webserver : index => droplet.ipv4_address
  }

  name   = each.value
  groups = ["webserver", "monitored"]

  variables = {
    providerName = "digitalocean01"
    providerType = "digitalocean"
  }
}

resource "ansible_host" "database" {
  for_each = {
    for index, droplet in digitalocean_droplet.database : index => droplet.ipv4_address
  }

  name   = each.value
  groups = ["database", "monitored"]

  variables = {
    providerName = "digitalocean01"
    providerType = "digitalocean"
  }
}

