variable "prefix" {}

variable "res_prefix" {}

variable "loc" {}

variable "rg_name" {}

variable "env" {}

variable "vm_prefix" {}

variable "vm_count" {}

variable "subnet_id" {}

variable "vm_size" {}

variable "vm_admin" {}

variable "pub_key_loc" {}

variable "os_disk" {
  default = {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
}

variable "image" {
  default = {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10"
    version   = "latest"
  }
}


