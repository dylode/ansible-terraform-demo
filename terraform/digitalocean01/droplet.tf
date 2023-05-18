resource "digitalocean_droplet" "webserver" {
  image    = "ubuntu-22-10-x64"
  name     = "webserver-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = ["xxx"]
  tags     = ["nginx"]
  count    = 2
}
resource "digitalocean_droplet" "mysql" {
  image    = "ubuntu-22-10-x64"
  name     = "mysql-${count.index + 1}"
  region   = "fra1"
  size     = "s-1vcpu-512mb-10gb"
  ssh_keys = ["xxx"]
  tags     = ["mysql"]
  count    = 1
}

resource "ansible_group" "nginx" {
  name     = "nginx"
  children = ["webserver"]
}
resource "ansible_group" "mysql" {
  name     = "mysql"
  children = ["mysql"]
}
