# User Assigned Identities via Terraform
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/user_assigned_identity
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment

# Azure Built-in Roles
# https://docs.microsoft.com/en-us/azure/role-based-access-control/built-in-roles#all

# # https://docs.microsoft.com/en-us/azure/aks/concepts-identity#identity-creating-and-operating-the-cluster-permissions
# data "azurerm_subscription" "current" {
# }

# resource "azurerm_role_definition" "aks_controlplane_ua_mi_role_definition" {
#   role_definition_id = "00000000-0000-0000-0000-000000000000"
#   name               = "${local.res_prefix}-aks_controlplane_ua_mi_role_definition"
#   scope              = data.azurerm_subscription.current.id

#   permissions {
#     actions     = ["Microsoft.Resources/subscriptions/resourceGroups/read",
#     ]
#     not_actions = []
#   }

#   assignable_scopes = [
#     data.azurerm_subscription.primary.id,
#   ]
# }


# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#identity
resource "azurerm_user_assigned_identity" "aks_controlplane_ua_mi" {
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  name                = "${local.res_prefix}-aks-controlplane-ua-mi"
  tags                = local.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#kubelet_identity
resource "azurerm_user_assigned_identity" "aks_kubelet_ua_mi" {
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  name                = "${local.res_prefix}-aks-kubelet-ua-mi"
  tags                = local.tags
}

# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#oms_agent_identity
resource "azurerm_user_assigned_identity" "aks_oms_agent_ua_mi" {
  resource_group_name = azurerm_resource_group.base.name
  location            = azurerm_resource_group.base.location
  name                = "${local.res_prefix}-aks-oms-agent-ua-mi"
  tags                = local.tags
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
