// will be used to store the state of 
module "azenv-tfstate-storage" {
  source     = "../modules/storage/"
  res_prefix = "azenv"
  rg_name    = azurerm_resource_group.base.name
  loc        = var.loc

  sg_name_suffix = "tfstateuks"

  // one container per provider
  blob_containers = ["docker", "helm", "azurerm", "azurerm-vm"]

  tags = local.tags
}

module "azshell-storage" {
  source          = "../modules/storage/"
  res_prefix      = "azshell"
  rg_name         = azurerm_resource_group.base.name
  blob_containers = []
  loc             = var.loc
  sg_name_suffix  = "uks"
  tags            = local.tags
}