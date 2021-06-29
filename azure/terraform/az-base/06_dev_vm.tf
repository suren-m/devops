data "azurerm_subnet" "vm" {
  name                 = "vm"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = azurerm_resource_group.base.name  
}

module "vm" {
  source     = "../modules/vm/"
  res_prefix = local.res_prefix
  vm_prefix = "dev"
  loc        = var.loc
  rg_name    = azurerm_resource_group.base.name 
  
  vm_count  = 1
  subnet_id = data.azurerm_subnet.vm.id

  vm_size = "Standard_D2as_v4"
  os_disk = {
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
    size_gb = "50"
  }

  vm_admin    = "suren"
  pub_key = file("../files/id_rsa.pub")

  tags = local.tags
}