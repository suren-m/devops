module "linux-agent-vm" {
  source     = "../modules/vm/"
  res_prefix = local.res_prefix
  vm_prefix  = "linux-agent"
  loc        = var.loc
  rg_name    = azurerm_resource_group.base.name

  vm_count  = 1
  subnet_id = data.azurerm_subnet.vm.id
  vm_size   = "Standard_D2as_v4"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    size_gb              = "50"
  }

  vm_admin = "suren"
  pub_key  = file("../files/id_rsa.pub")
  custom_data  = file("../files/cloud_init")


  tags = local.tags
}

