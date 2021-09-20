module "linux-dev-vm" {
  source     = "../modules/vm/"
  res_prefix = local.res_prefix
  vm_prefix  = "dev"
  loc        = var.loc
  rg_name    = azurerm_resource_group.rg.name

  vm_count  = 2
  subnet_id = data.azurerm_subnet.vm.id
  vm_size   = "Standard_D2as_v4"

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


  tags = merge(local.tags, { "os" = "linux" })i
}

