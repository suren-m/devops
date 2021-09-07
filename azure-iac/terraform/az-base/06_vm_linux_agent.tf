module "linux-agent-vm" {
  source     = "../modules/vm/"
  res_prefix = local.res_prefix
  vm_prefix  = "linux-agent"
  loc        = var.loc
  rg_name    = data.azurerm_resource_group.base.name

  vm_count  = 1
  subnet_id = data.azurerm_subnet.vm.id

  vm_size = "Standard_D2as_v4"
  storage_os_disk = {
    create_option        = "FromImage"
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    size_gb              = "50"
  }

  delete_os_disk = true

  vm_admin    = "suren"
  pub_key     = file("../files/id_rsa.pub")
  custom_data = file("../files/cloud_init")

  # https://docs.microsoft.com/en-us/cli/azure/vm/image?view=azure-cli-latest
  image = {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  tags = local.tags
}

