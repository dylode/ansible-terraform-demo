resource "hcloud_server" "webserver" {
  image        = "debian-11"
  name         = "webserver-${count.index + 1}"
  location     = "fsn1"
  server_type  = "cx11"
  ssh_keys     = ["dylan@dylan-mint"]
  
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  count    = 2
}

resource "hcloud_server" "database" {
  image        = "debian-11"
  name         = "database-${count.index + 1}"
  location     = "fsn1"
  server_type  = "cx11"
  ssh_keys     = ["dylan@dylan-mint"]
  
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  count    = 3
}

resource "ansible_host" "webserver" {
  for_each = {
    for index, server in hcloud_server.webserver : server.name => server.ipv4_address
  }

  name   = each.key
  groups = ["webserver", "monitored"]

  variables = {
    provider_name = "hetzner01"
    provider_type = "hetzner"
    ansible_host = each.value
  }
}

resource "ansible_host" "database" {
  for_each = {
    for index, server in hcloud_server.database : server.name => server.ipv4_address
  }

  name   = each.key
  groups = ["database", "monitored"]

  variables = {
    provider_name = "hetzner01"
    provider_type = "hetzner"
    ansible_host = each.value
  }
}

