variable "webserver-ips" {
  default = {
            "0" = "10.187.10.30/24"
            "1" = "10.187.10.31/24"
            "2" = "10.187.10.32/24"
            "3" = "10.187.10.33/24"
            "4" = "10.187.10.34/24"
      }
}

resource "proxmox_lxc" "webserver" {
  target_node  = "pve01"
  hostname     = "webserver-${count.index + 1}"
  ostemplate   = "dylan_additional_storage:vztmpl/debian-11-standard_11.6-1_amd64.tar.zst"
  unprivileged = true
  count        = 5
  pool         = "dylan_pool"
  start        = true
  onboot       = true
  ssh_public_keys = <<-EOT
    ssh-rsa xxxxx
  EOT

  rootfs {
    storage = "dylan_storage"
    size    = "4G"
  }

  network {
    name   = "eth0"
    bridge = "vmbr100"
    ip     = "${lookup(var.webserver-ips, count.index)}"
    ip6    = "auto"
    gw     = "10.187.10.1"
        tag    = "10"
      }
}

resource "ansible_host" "webserver" {
  for_each = {
    for index, lxc in proxmox_lxc.webserver : lxc.hostname => lxc.network[0].ip
  }

  name   = each.key
  groups = ["webserver", "monitored"]

  variables = {
    ansible_host  = split("/", each.value)[0]
    provider_name = "pve01"
    provider_type = "proxmox"
    resource_type = "lxc"
  }
}

