// Monitoring
resource "azurerm_resource_group" "monitoring_rg" {
  name     = "${local.res_prefix}-monitoring"
  location = var.loc.long
}

module "monitoring" {
  source     = "./modules/monitoring/"
  res_prefix = local.res_prefix
  prefix     = var.prefix
  env        = var.env
  rg_name    = azurerm_resource_group.monitoring_rg.name
  loc        = var.loc
}