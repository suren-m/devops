resource "azurerm_kubernetes_cluster" "aks_kubenet" {
  name                = "demo-kubenet"  
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_tier            = "Free"
  kubernetes_version  = var.kubernetes_version

  dns_prefix = "${var.aks_cluster_name}-aks"
  # private_cluster_enabled = true
  # node_resource_group = "aks-mc-${azurerm_resource_group.rg.name}"

  default_node_pool {
    name                 = "default"
    type                 = "VirtualMachineScaleSets"
    vm_size              = "Standard_B2s"
    availability_zones   = ["1", "2", "3"]
    enable_auto_scaling  = true
    node_count           = 1
    max_count            = 2
    min_count            = 1
    orchestrator_version = var.kubernetes_version
    vnet_subnet_id       = data.azurerm_subnet.aks.id
  }

  linux_profile {
    admin_username = "suren"
    ssh_key {
      key_data = file("../files/id_rsa.pub")
    }
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

  role_based_access_control {
    enabled = true
    azure_active_directory {
      managed = true
    }
  }

  addon_profile {
    oms_agent {
      enabled                    = true
      log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
    }
    azure_policy {
      enabled = true
    }
  }

  # https://docs.microsoft.com/en-us/azure/aks/use-managed-identity#bring-your-own-control-plane-mi
  identity {
    type                      = "UserAssigned"
    user_assigned_identity_id = data.azurerm_user_assigned_identity.aks_controlplane_ua_mi.id
  }

  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster (see identity)
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity
  # kubelet_identity {
  #   user_assigned_identity_id = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.id
  #   client_id                 = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.client_id
  #   object_id                 = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.principal_id
  # }

}

resource "azurerm_kubernetes_cluster_node_pool" "aks_kubenet_common" {
  name                  = "common"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.aks_kubenet.id
  enable_auto_scaling   = true
  vm_size               = "Standard_B2s"
  node_count            = 1
  max_count             = 3
  min_count             = 1
  max_pods              = 20
  orchestrator_version  = var.kubernetes_version
  availability_zones    = [1, 2, 3]
  mode                  = "User"
  node_labels           = { workloads = "general" }
  vnet_subnet_id        = data.azurerm_subnet.aks.id
}