// Networking 
data "azurerm_subnet" "apigw" {
  name                 = "sub-4094-3"
  virtual_network_name = local.base_prefix
  resource_group_name  = local.base_rg
}

data "azurerm_subnet" "webapi" {
  name                 = "sub-4094-4"
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

