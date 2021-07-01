data "azurerm_user_assigned_identity" "controlplane_identity" {
  resource_group_name = "identities"
  name                = "aks-controlplane-ua-mi"
}

data "azurerm_user_assigned_identity" "kubelet_identity" {
  resource_group_name = "identities"
  name                = "aks-kubelet-ua-mi"
}