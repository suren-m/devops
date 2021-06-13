// AKS
resource "azurerm_resource_group" "aks_rg" {
  name     = "${local.res_prefix}-aks"
  location = var.loc.long
}

module "aks" {
  source     = "./modules/aks/"
  res_prefix = local.res_prefix

  aks_cluster_name = local.res_prefix
  loc              = var.loc
  rg_name          = azurerm_resource_group.aks_rg.name

  kubernetes_version = var.kubernetes_version

  vm_size      = var.aks_vm_size
  default_pool = var.default_pool
  user_pool    = var.user_pool

  vnet_subnet_id = data.azurerm_subnet.aks.id

  network_profile = {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = "10.16.0.0/16"
    dns_service_ip     = "10.16.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    pod_cidr           = null
  }

  log_analytics_workspace_id = module.monitoring.law.id
}