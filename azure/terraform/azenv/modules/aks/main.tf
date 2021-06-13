resource "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  location            = var.loc.long
  resource_group_name = var.rg_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.aks_cluster_name
  sku_tier            = "Free"

  default_node_pool {
    name               = "default"
    availability_zones = ["1", "2"]

    enable_auto_scaling = true
    node_count          = var.default_pool.init_count
    min_count           = var.default_pool.min_count
    max_count           = var.default_pool.max_count

    vm_size        = var.vm_size
    vnet_subnet_id = var.vnet_subnet_id

    node_labels = var.node_labels
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    network_policy     = var.network_profile.network_policy
    service_cidr       = var.network_profile.service_cidr
    dns_service_ip     = var.network_profile.dns_service_ip
    docker_bridge_cidr = var.network_profile.docker_bridge_cidr
    pod_cidr           = var.network_profile.pod_cidr
  }

  role_based_access_control {
    enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  addon_profile {

    azure_policy {
      enabled = true
    }

    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "userpool" {
  name                  = "userpool"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
  vnet_subnet_id        = var.vnet_subnet_id
  availability_zones    = ["1", "2"]

  enable_auto_scaling = true
  node_count          = var.user_pool.init_count
  min_count           = var.user_pool.min_count
  max_count           = var.user_pool.max_count
  # max_pods = 30 

  vm_size         = var.vm_size
  os_type         = "Linux"
  os_disk_size_gb = "50"

  enable_node_public_ip = false
  node_labels           = var.user_workloads_node_labels
}