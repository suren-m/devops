// Networking 
data "azurerm_subnet" "default" {
  name                 = "default"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

data "azurerm_subnet" "vm" {
  name                 = "vm"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

data "azurerm_subnet" "aks" {
  name                 = "aks"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

data "azurerm_subnet" "k8s" {
  name                 = "k8s-iaas"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

# law
data "azurerm_log_analytics_workspace" "law" {
  name                = local.base_prefix  
  resource_group_name  = local.base_rg
}

