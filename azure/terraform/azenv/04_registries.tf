// ACR
resource "azurerm_resource_group" "acr_rg" {
  name     = "${var.prefix}-${var.env}-${var.loc.short}-registry"
  location = var.loc.long
}

module "acr_docker" {
  source     = "./modules/acr/"
  res_prefix = local.alphanumeric_only_res_prefix
  prefix     = var.prefix
  env        = var.env
  rg_name    = azurerm_resource_group.acr_rg.name
  loc        = var.loc

  name_suffix = "reg"
}

module "acr_helm" {
  source     = "./modules/acr/"
  res_prefix = local.alphanumeric_only_res_prefix
  prefix     = var.prefix
  env        = var.env
  rg_name    = azurerm_resource_group.acr_rg.name
  loc        = var.loc

  name_suffix = "helmreg"
}

// will be used to store the state of 
module "storage" {
  source     = "./modules/storage/"
  res_prefix = local.alphanumeric_only_res_prefix

  prefix  = var.prefix
  env     = var.env
  rg_name = azurerm_resource_group.acr_rg.name
  loc     = var.loc



  sg_name_suffix = "tfstate"

  // one container per provider
  blob_containers = ["docker-containers", "helm-charts"]
}

