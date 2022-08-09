// resource prefix
// locals will only be visible to root module, so using variables here

locals {
  base_prefix                   = terraform.workspace == "default" ? "${var.base_prefix}-${var.loc.short}" : "${terraform.workspace}-${var.base_prefix}-${var.loc.short}"
  alphanumeric_only_base_prefix = terraform.workspace == "default" ? "${var.base_prefix}${var.loc.short}" : "${terraform.workspace}${var.base_prefix}${var.loc.short}"
  base_rg                       = var.base_rg

  res_prefix                   = terraform.workspace == "default" ? "${var.prefix}-${var.loc.short}" : "${terraform.workspace}-${var.prefix}-${var.loc.short}"
  alphanumeric_only_res_prefix = terraform.workspace == "default" ? "${var.prefix}${var.loc.short}" : "${terraform.workspace}${var.prefix}${var.loc.short}"

  tags = {
    res_prefix   = "${local.res_prefix}"
    tf_workspace = "${terraform.workspace}"
    environment  = "az-env"
    pipeline     = "tf-az-env"
  }
}

# Created in base env

# resource "azurerm_role_assignment" "network_contributor" {
#   scope                = data.azurerm_virtual_network.vnet.id
#   role_definition_name = "Network Contributor"
#   principal_id         = data.azurerm_user_assigned_identity.aks_controlplane_ua_mi.principal_id
# }

# resource "azurerm_role_assignment" "acr_pull" {
#   scope                = data.azurerm_resource_group.base_rg.id
#   role_definition_name = "AcrPull"
#   principal_id         = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.principal_id
# }

# resource "azurerm_role_assignment" "oms_law" {
#   scope                = data.azurerm_log_analytics_workspace.law.id
#   role_definition_name = "Log Analytics Contributor"
#   principal_id         = data.azurerm_user_assigned_identity.aks_oms_agent_ua_mi.principal_id
# }

# utils
# data "http" "tf_check" {
#   url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

#   request_headers = {
#     Accept = "application/json"
#   }
# }

# resource "azurerm_resource_group" "live_demo_rg" {
#   name     = "${local.res_prefix}-livedemo-rg"
#   location = var.loc.long
# }




