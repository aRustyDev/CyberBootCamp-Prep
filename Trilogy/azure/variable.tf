variable "jump_user" {
  default = "azadmin"
}

variable "web_user" {
  default = "azadmin"
}

variable "default_user" {
  default = "adminuser"
}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}