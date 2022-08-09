resource "azurerm_kubernetes_cluster" "aks_backend_dualzone" {
  name                = "dualzone"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = data.azurerm_resource_group.rg.location
  sku_tier            = "Free"
  kubernetes_version  = var.kubernetes_version

  dns_prefix = "dualzone"
  automatic_channel_upgrade = "stable"
  # private_cluster_enabled = true

  default_node_pool {
    name                 = "default"
    type                 = "VirtualMachineScaleSets"
    vm_size              = "Standard_D2as_v4"
    zones   = ["1", "2"]
    enable_auto_scaling  = true
    node_count           = 1
    max_count            = 2
    min_count            = 1
    orchestrator_version = var.kubernetes_version
    vnet_subnet_id       = data.azurerm_subnet.aks2.id
  }

  auto_scaler_profile {
    balance_similar_node_groups = true
  }

  network_profile {
    network_plugin     = "azure"
    dns_service_ip     = "10.2.0.10"
    docker_bridge_cidr = "172.17.0.1/16"
    service_cidr       = "10.2.0.0/24"
  }

  # https://docs.microsoft.com/en-us/azure/aks/use-managed-identity#bring-your-own-control-plane-mi
  identity {
    type                      = "UserAssigned"
    identity_ids = [data.azurerm_user_assigned_identity.aks_controlplane_ua_mi.id]
  }

  kubelet_identity {
    user_assigned_identity_id = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.id
    client_id                 = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.client_id
    object_id                 = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.principal_id
  }

  azure_policy_enabled = true

  oms_agent {
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
    secret_rotation_interval = "5m"
  }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks_backend_az1" {
  name                  = "az1"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_backend_dualzone.id
  enable_auto_scaling   = true
  vm_size               = "Standard_D2as_v4"
  node_count            = 1
  max_count             = 3
  min_count             = 1
  max_pods              = 30
  orchestrator_version  = var.kubernetes_version
  zones    = [1]
  mode                  = "User"
  vnet_subnet_id        = data.azurerm_subnet.aks2.id
  node_taints           = ["zone=az1:NoSchedule"]
}

resource "azurerm_kubernetes_cluster_node_pool" "aks_backend_az2" {
  name                  = "az2"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_backend_dualzone.id
  enable_auto_scaling   = true
  vm_size               = "Standard_D2as_v4"
  node_count            = 1
  max_count             = 3
  min_count             = 1
  max_pods              = 30
  orchestrator_version  = var.kubernetes_version
  zones    = [2]
  mode                  = "User"
  vnet_subnet_id        = data.azurerm_subnet.aks2.id
  node_taints           = ["zone=az2:NoSchedule"]
}