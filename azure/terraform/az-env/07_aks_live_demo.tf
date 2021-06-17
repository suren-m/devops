
module "aks-demo" {
  source     = "./modules/aks-demo/"
  res_prefix = "demo2"

  aks_cluster_name = "demo2"
  loc              = var.loc
  rg_name          = azurerm_resource_group.aks_rg.name

  kubernetes_version = var.kubernetes_version

  vm_size      = var.aks_vm_size
  
  aks_premiumpool_vm_size = var.aks_premiumpool_vm_size
  aks_basicpool_vm_size = var.aks_basicpool_vm_size

  default_pool = var.default_pool
  user_pool    = var.user_pool

  vnet_subnet_id = data.azurerm_subnet.aks-demo2.id

  network_profile = {
    network_plugin     = "azure"
    network_policy     = "azure"
    service_cidr       = "10.16.0.0/16"
    dns_service_ip     = "10.16.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    pod_cidr           = null
  }
  basicpool_taints = [ "basic=true:NoSchedule" ]
  premiumpool_taints = [ "premium=true:NoSchedule" ]
  
  log_analytics_workspace_id = module.monitoring.law.id
}