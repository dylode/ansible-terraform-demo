
resource "ansible_group" "nginx" {
  name     = "nginx"
  children = []
}
resource "ansible_group" "mysql" {
  name     = "mysql"
  children = []
}
