resource "digitalocean_droplet" "webserver" {
  image    = "ubuntu-22-10-x64"
  name     = "webserver-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = ["f1:77:5a:66:bf:57:d0:a9:b1:8b:03:e1:7f:35:c8:62"]
  tags     = ["nginx", "node_exporter"]
  count    = 3
}

resource "digitalocean_droplet" "database" {
  image    = "ubuntu-22-10-x64"
  name     = "database-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = ["f1:77:5a:66:bf:57:d0:a9:b1:8b:03:e1:7f:35:c8:62"]
  tags     = ["mysql", "node_exporter"]
  count    = 1
}

resource "ansible_host" "webserver" {
  for_each = toset(digitalocean_droplet.webserver.*.ipv4_address)
  name   = each.key
  groups = ["nginx", "node_exporter"]

  variables = {
    providerName = "digitalocean01"
    providerType = "digitalocean"
  }
}

resource "ansible_host" "database" {
  for_each = toset(digitalocean_droplet.database.*.ipv4_address)
  name   = each.key
  groups = ["mysql", "node_exporter"]

  variables = {
    providerName = "digitalocean01"
    providerType = "digitalocean"
  }
}

