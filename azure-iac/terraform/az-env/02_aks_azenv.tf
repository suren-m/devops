# resource "azurerm_kubernetes_cluster" "aks" {
#   name                = var.aks_cluster_name
#   resource_group_name = data.azurerm_resource_group.rg.name
#   location            = data.azurerm_resource_group.rg.location
#   sku_tier            = "Paid"
#   kubernetes_version  = var.kubernetes_version
#   oidc_issuer_enabled = true
#   open_service_mesh_enabled = true
#   workload_identity_enabled = true

#   dns_prefix = "${var.aks_cluster_name}-aks"  
#   # private_cluster_enabled = true
#   # node_resource_group = "aks-mc-${data.azurerm_resource_group.rg.name}"

#   default_node_pool {
#     name                 = "default"
#     type                 = "VirtualMachineScaleSets"
#     vm_size              = "Standard_D2as_v4"
#     zones                = ["1", "2", "3"]
#     enable_auto_scaling  = true
#     max_count            = 3
#     min_count            = 2
#     max_pods             = 75
#     orchestrator_version = var.kubernetes_version    
#     vnet_subnet_id       = data.azurerm_subnet.aks.id

#     only_critical_addons_enabled = true
#     # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster#only_critical_addons_enabled
#     # https://docs.microsoft.com/en-us/azure/aks/use-system-pools?tabs=azure-cli
#   }

#   # linux_profile {
#   #   admin_username = "suren"
#   #   ssh_key {
#   #     key_data = file("../files/id_rsa.pub")
#   #   }
#   # }

#   auto_scaler_profile {
#     balance_similar_node_groups = true
#   }

#   network_profile {
#     network_plugin     = "azure"
#     dns_service_ip     = "10.2.0.10"
#     docker_bridge_cidr = "172.17.0.1/16"
#     service_cidr       = "10.2.0.0/24"
#   }

#   # https://docs.microsoft.com/en-us/azure/aks/use-managed-identity#bring-your-own-control-plane-mi
#   identity {
#     type                      = "UserAssigned"
#     identity_ids = [data.azurerm_user_assigned_identity.aks_controlplane_ua_mi.id]
#   }

#   # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster (see identity)
#   # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity
#   kubelet_identity {
#     user_assigned_identity_id = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.id
#     client_id                 = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.client_id
#     object_id                 = data.azurerm_user_assigned_identity.aks_kubelet_ua_mi.principal_id
#   }

#   azure_policy_enabled = true

#   oms_agent {
#       log_analytics_workspace_id = data.azurerm_log_analytics_workspace.law.id
#   }

#   key_vault_secrets_provider {
#     secret_rotation_enabled = true
#     secret_rotation_interval = "5m"
#   }
# }

# resource "azurerm_kubernetes_cluster_node_pool" "web" {
#   name                  = "web"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   enable_auto_scaling   = true
#   vm_size               = "Standard_D2as_v4"
#   max_count             = 9
#   min_count             = 3
#   max_pods              = 30
#   orchestrator_version  = var.kubernetes_version
#   zones                 = [1, 2, 3]
#   mode                  = "User"
#   node_labels           = { workloads = "web" }
#   vnet_subnet_id        = data.azurerm_subnet.aks.id
# }

# resource "azurerm_kubernetes_cluster_node_pool" "db" {
#   name                  = "db"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   enable_auto_scaling   = true
#   vm_size               = "Standard_D2as_v4"
#   max_count             = 3
#   min_count             = 1
#   max_pods              = 15
#   orchestrator_version  = var.kubernetes_version
#   zones                 = [1, 2, 3]
#   mode                  = "User"
#   node_labels           = { workloads = "db" }
#   node_taints           = ["workloads=db:NoSchedule"]
#   vnet_subnet_id        = data.azurerm_subnet.aks.id
# }


# resource "azurerm_kubernetes_cluster_node_pool" "intensive" {
#   name                  = "intensive"
#   kubernetes_cluster_id = azurerm_kubernetes_cluster.aks.id
#   enable_auto_scaling   = true
#   vm_size               = "Standard_F8s_v2"
#   max_count             = 2
#   min_count             = 1
#   max_pods              = 50
#   orchestrator_version  = var.kubernetes_version
#   zones                 = [1, 2, 3]
#   mode                  = "User"
#   node_labels           = { workloads = "intensive" }
#   node_taints           = ["workloads=intensive:NoSchedule"]
#   vnet_subnet_id        = data.azurerm_subnet.aks.id
# }

