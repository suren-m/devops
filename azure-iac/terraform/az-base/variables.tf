variable "prefix" {

}

variable "loc" {

}

# Networking
variable "vnet_addr_space" {

}

variable "vnet_subnets" {

} 
variable "win_admin_username" {}
variable "win_admin_pass"{
  type        = string
  sensitive   = true
}