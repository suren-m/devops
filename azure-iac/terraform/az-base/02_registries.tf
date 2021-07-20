module "acr_docker" {
  source     = "../modules/acr/"
  res_prefix = local.alphanumeric_only_res_prefix
  rg_name    = azurerm_resource_group.base.name
  loc        = var.loc

  name_suffix = "reg"
  tags        = local.tags
}

module "acr_helm" {
  source     = "../modules/acr/"
  res_prefix = local.alphanumeric_only_res_prefix
  rg_name    = azurerm_resource_group.base.name
  loc        = var.loc

  name_suffix = "helmreg"
  tags        = local.tags
}


