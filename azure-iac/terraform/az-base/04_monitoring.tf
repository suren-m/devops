// Monitoring
module "monitoring" {
  source     = "../modules/monitoring/"
  res_prefix = local.res_prefix
  rg_name    = azurerm_resource_group.base.name
  loc        = var.loc
  tags       = local.tags
}