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

resource "azurerm_linux_virtual_machine" "vm" {
  count = var.vm_count

  name = "${var.res_prefix}-${var.vm_prefix}-${count.index}"

  resource_group_name = var.rg_name
  location            = var.loc.long

  size = var.vm_size

  admin_username = var.vm_admin
  admin_ssh_key {
    username   = var.vm_admin
    public_key = file(var.pub_key_loc)
  }

  network_interface_ids = [
    element(azurerm_network_interface.nic.*.id, count.index),
  ]

  os_disk {
    caching              = var.os_disk.caching
    storage_account_type = var.os_disk.storage_account_type
  }

  source_image_reference {
    publisher = var.image.publisher
    offer     = var.image.offer
    sku       = var.image.sku
    version   = var.image.version
  }
}
