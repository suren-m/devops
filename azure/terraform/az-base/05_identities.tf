# User Assigned Identities via Terraform
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment

# Azure Built-in Roles
# https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#all

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#identity
resource "azurerm_user_assigned_identity" "aks_controlplane_ua_mi" {
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  name = "${local.res_prefix}-aks-controlplane-ua-mi"
  tags = local.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#kubelet_identity
resource "azurerm_user_assigned_identity" "aks_kubelet_ua_mi" {
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  name = "${local.res_prefix}-aks-kubelet-ua-mi"
  tags = local.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#oms_agent_identity
resource "azurerm_user_assigned_identity" "aks_oms_agent_ua_mi" {
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  name = "${local.res_prefix}-aks-oms-agent-ua-mi"
  tags = local.tags
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = module.networking.vnet.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_controlplane_ua_mi.principal_id
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = azurerm_resource_group.base.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.aks_kubelet_ua_mi.principal_id
}

resource "azurerm_role_assignment" "oms_law" {
  scope                = module.monitoring.law.id
  role_definition_name = "Log Analytics Contributor"
  principal_id         = azurerm_user_assigned_identity.aks_oms_agent_ua_mi.principal_id
}
