data "azurerm_subnet" "private-aks" {
  name                 = "private-aks"
  virtual_network_name = local.vnet
  resource_group_name  = local.vnet_rg
}

data "azurerm_user_assigned_identity" "controlplane_identity" {
  resource_group_name = "identities"
  name                = "aks-controlplane-ua-mi"
}

data "azurerm_user_assigned_identity" "kubelet_identity" {
  resource_group_name = "identities"
  name                = "aks-kubelet-ua-mi"
}

# New resources
resource "azurerm_resource_group" "pvt-aks" {
  name     = "private-aks"
  location = "uk south"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                    = "private-aks"
  location                = azurerm_resource_group.pvt-aks.location
  resource_group_name     = azurerm_resource_group.pvt-aks.name
  sku_tier                = "Free"
  dns_prefix              = "pvt"
  kubernetes_version      = "1.20.5"
  private_cluster_enabled = true

  node_resource_group = "private-aks-node-rg"

  # used for Active Directory integration on private clusters...
  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
    }
  }

  # https://docs.microsoft.com/en-us/azure/aks/use-managed-identity#bring-your-own-control-plane-mi
  identity {
    type                      = "UserAssigned"
    user_assigned_identity_id = data.azurerm_user_assigned_identity.controlplane_identity.id
  }

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster (see identity)
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity
  #   kubelet_identity {
  #     user_assigned_identity_id = data.azurerm_user_assigned_identity.kubelet_identity.id
  #     client_id = data.azurerm_user_assigned_identity.kubelet_identity.client_id
  #     object_id = data.azurerm_user_assigned_identity.kubelet_identity.principal_id
  #   }

  default_node_pool {
    name                 = "default"
    type                 = "VirtualMachineScaleSets"
    vm_size              = "Standard_F16s_v2"
    availability_zones   = ["1", "2", "3"]
    enable_auto_scaling  = true
    node_count           = 1
    max_count            = 1
    min_count            = 1
    orchestrator_version = "1.20.5"
    vnet_subnet_id       = data.azurerm_subnet.private-aks.id
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.0.2.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.0.2.0/24"
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = module.monitoring.law.id
    }
  }
  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }
}

//
// ZONE 1 NODEPOOLS
//
resource "azurerm_proximity_placement_group" "zone1" {
  name                = "private-aks-redis-zone1-ppg"
  location            = azurerm_resource_group.pvt-aks.location
  resource_group_name = azurerm_resource_group.pvt-aks.name
}

resource "azurerm_kubernetes_cluster_node_pool" "zone1" {
  name                         = "appzone1"
  kubernetes_cluster_id        = azurerm_kubernetes_cluster.aks.id
  enable_auto_scaling          = true
  vm_size                      = "Standard_F16s_v2"
  node_count                   = 1
  max_count                    = 3
  min_count                    = 1
  max_pods                     = 10
  orchestrator_version         = "1.20.5"
  availability_zones           = [1]
  mode                         = "User"
  proximity_placement_group_id = azurerm_proximity_placement_group.zone1.id
  node_labels                  = { "pool" = "zone1" }
  vnet_subnet_id               = data.azurerm_subnet.private-aks.id
}

resource "azurerm_kubernetes_cluster_node_pool" "redis_zone1" {
  name                         = "rediszone1"
  kubernetes_cluster_id        = azurerm_kubernetes_cluster.aks.id
  enable_auto_scaling          = true
  vm_size                      = "Standard_F8s_v2"
  node_count                   = 1
  max_count                    = 3
  min_count                    = 1
  max_pods                     = 10
  orchestrator_version         = "1.20.5"
  availability_zones           = [1]
  mode                         = "User"
  proximity_placement_group_id = azurerm_proximity_placement_group.zone1.id
  node_labels                  = { "pool" = "zone1", "type" : "redis" }
  node_taints                  = ["app=redis:NoSchedule"]
  vnet_subnet_id               = data.azurerm_subnet.private-aks.id

}

//
// ZONE 2 NODEPOOLS
//
resource "azurerm_proximity_placement_group" "zone2" {
  name                = "private-aks-redis-zone2-ppg"
  location            = azurerm_resource_group.pvt-aks.location
  resource_group_name = azurerm_resource_group.pvt-aks.name
}

resource "azurerm_kubernetes_cluster_node_pool" "zone2" {
  name                         = "appzone2"
  kubernetes_cluster_id        = azurerm_kubernetes_cluster.aks.id
  enable_auto_scaling          = true
  vm_size                      = "Standard_F16s_v2"
  node_count                   = 1
  max_count                    = 3
  min_count                    = 1
  max_pods                     = 10
  orchestrator_version         = "1.20.5"
  availability_zones           = [2]
  mode                         = "User"
  proximity_placement_group_id = azurerm_proximity_placement_group.zone2.id
  node_labels                  = { "pool" = "zone2" }
  vnet_subnet_id               = data.azurerm_subnet.private-aks.id
}

resource "azurerm_kubernetes_cluster_node_pool" "redis_zone2" {
  name                         = "rediszone2"
  kubernetes_cluster_id        = azurerm_kubernetes_cluster.aks.id
  enable_auto_scaling          = true
  vm_size                      = "Standard_F8s_v2"
  node_count                   = 1
  max_count                    = 3
  min_count                    = 1
  max_pods                     = 10
  orchestrator_version         = "1.20.5"
  availability_zones           = [2]
  mode                         = "User"
  proximity_placement_group_id = azurerm_proximity_placement_group.zone2.id
  node_labels                  = { "pool" = "zone2", "type" : "redis" }
  node_taints                  = ["app=redis:NoSchedule"]
  vnet_subnet_id               = data.azurerm_subnet.private-aks.id
}

