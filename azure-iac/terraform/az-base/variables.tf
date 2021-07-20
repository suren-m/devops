variable "prefix" {

}

variable "loc" {

}

# Networking
variable "vnet_addr_space" {

}

variable "vnet_subnets" {

}
variable "winuser" {}
variable "winpass" {
  type      = string
  sensitive = true
}