// Networking 
data "azurerm_resource_group" "rg" {
  name     = local.res_prefix   
}


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

data "azurerm_subnet" "aks2" {
  name                 = "aks-2"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

data "azurerm_subnet" "aks3" {
  name                 = "sub-4094"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

data "azurerm_subnet" "sub256" {
  name                 = "sub-256"
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
  resource_group_name = local.base_rg
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#identity
data "azurerm_user_assigned_identity" "aks_controlplane_ua_mi" {
  name                = "${local.base_prefix}-aks-controlplane-ua-mi"
  resource_group_name = local.base_rg
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#kubelet_identity
data "azurerm_user_assigned_identity" "aks_kubelet_ua_mi" {
  name                = "${local.base_prefix}-aks-kubelet-ua-mi"
  resource_group_name = local.base_rg
}

