variable "res_prefix" {}

variable "loc" {}

variable "rg_name" {}

variable "vm_prefix" {}

variable "vm_count" {}

variable "subnet_id" {}

variable "vm_size" {}

variable "vm_admin" {}

variable "pub_key" {}

variable "custom_data" {}

variable "os_disk" {
  default = {
    create_option       = "FromImage"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    size_gb              = "50"
  }
}

variable "delete_os_disk" {
  default = true  
}

variable "image" {
  default = {
    publisher = "Debian"
    offer     = "debian-10"
    sku       = "10-cloudinit"
    version   = "latest"
  }
}

variable "tags" {}
