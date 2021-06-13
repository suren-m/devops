
resource "azurerm_log_analytics_workspace" "law" {
  name                = var.res_prefix
  location            = var.loc.long
  resource_group_name = var.rg_name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}