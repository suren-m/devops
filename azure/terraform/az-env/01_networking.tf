// Networking 
locals {
  vnet = local.res_prefix
  vnet_rg = "${local.res_prefix}-scaffolding"
}

data "azurerm_subnet" "default" {
  name                 = "default"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_subnet" "vms" {
  name                 = "vms"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_subnet" "aks" {
  name                 = "aks"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_subnet" "aks-demo1" {
  name                 = "aks-demo1"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_subnet" "aks-demo2" {
  name                 = "aks-demo2"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_subnet" "aks-demo3" {
  name                 = "aks-demo3"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_subnet" "k8s" {
  name                 = "k8s-iaas"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}



