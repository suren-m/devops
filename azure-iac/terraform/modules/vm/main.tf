resource "azurerm_network_interface" "nic" {
  count = var.vm_count

  name = "${var.res_prefix}-${var.vm_prefix}-${count.index}"

  location            = var.loc.long
  resource_group_name = var.rg_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  count = var.vm_count

  name = "${var.res_prefix}-${var.vm_prefix}-${count.index}"

  resource_group_name = var.rg_name
  location            = var.loc.long

  vm_size = var.vm_size

  os_profile {
    computer_name = "${var.res_prefix}-${var.vm_prefix}-${count.index}"
    admin_username = "suren" 
    # custom_data = var.custom_data # cloud init
  }
  os_profile_linux_config {
    disable_password_authentication = true
    ssh_keys {
      key_data = var.pub_key
      path = "/home/suren/.ssh/authorized_keys"
    }
  }

  network_interface_ids = [
    element(azurerm_network_interface.nic.*.id, count.index),
  ]

  storage_os_disk {
    create_option     = var.os_disk.create_option
    name = "${var.res_prefix}-${var.vm_prefix}-${count.index}-osdisk"
    caching              = var.os_disk.caching
    managed_disk_type  = var.os_disk.storage_account_type
    disk_size_gb         = var.os_disk.size_gb
  }

  delete_os_disk_on_termination = var.delete_os_disk

  storage_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }
  
  tags = var.tags
}
