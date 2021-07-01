# data "azurerm_subnet" "aks-kubenet" {
#   name                 = "aks-demo1"
#   virtual_network_name = local.vnet
#   resource_group_name  = local.vnet_rg
# }

# # New resources
# resource "azurerm_resource_group" "aks-kubenet" {
#   name     = "aks-kubenet"
#   location = "uk south"
# }

# resource "azurerm_kubernetes_cluster" "aks-kubenet" {
#   name                    = "aks-kubenet"
#   location                = azurerm_resource_group.aks-kubenet.location
#   resource_group_name     = azurerm_resource_group.aks-kubenet.name
#   sku_tier                = "Free"
#   # Check this again..
#   # dns_prefix              = "pvt"
#   # what about private dns zone id
#   dns_prefix = "aks-kubenet-dns"

#   kubernetes_version      = "1.19.11"
#   #private_cluster_enabled = true

#   node_resource_group = "aks-kubenet-node-rg"

#   # used for Active Directory integration on private clusters...
#   role_based_access_control {
#     enabled = true
#     azure_active_directory {
#       managed = true
#     }
#   }

#   # https://docs.microsoft.com/en-us/azure/aks/use-managed-identity#bring-your-own-control-plane-mi
#   identity {
#     type                      = "UserAssigned"
#     user_assigned_identity_id = data.azurerm_user_assigned_identity.controlplane_identity.id
#   }

#   # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kubernetes_cluster (see identity)
#   # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/user_assigned_identity
#   #   kubelet_identity {
#   #     user_assigned_identity_id = data.azurerm_user_assigned_identity.kubelet_identity.id
#   #     client_id = data.azurerm_user_assigned_identity.kubelet_identity.client_id
#   #     object_id = data.azurerm_user_assigned_identity.kubelet_identity.principal_id
#   #   }

#   default_node_pool {
#     name                 = "default"
#     type                 = "VirtualMachineScaleSets"
#     vm_size              = "Standard_F4s_v2"
#     availability_zones   = ["1", "2", "3"]
#     enable_auto_scaling  = true
#     node_count           = 1
#     max_count            = 1
#     min_count            = 1
#     orchestrator_version = "1.19.11"
#     vnet_subnet_id       = data.azurerm_subnet.aks-kubenet.id
#   }

#   linux_profile {
#     admin_username = "suren"
#     ssh_key {
#       key_data = file("files/id_rsa.pub") 
#     }
#   }

#   network_profile {
#     network_plugin     = "kubenet"
#     network_policy     = "calico"
#     dns_service_ip     = "10.2.0.10"
#     docker_bridge_cidr = "172.17.0.1/16"
#     service_cidr       = "10.2.0.0/24"
#     pod_cidr           = "10.244.0.0/16"
#   }

#   auto_scaler_profile {
#     balance_similar_node_groups = true
#   }

#   addon_profile {
#     oms_agent {
#       enabled                    = true
#       log_analytics_workspace_id = module.monitoring.law.id
#     }
#   }
#   lifecycle {
#     ignore_changes = [default_node_pool[0].node_count]
#   }
# }

# resource "azurerm_kubernetes_cluster_node_pool" "aks-kubenet-apppool" {
#   name                         = "apppool"
#   kubernetes_cluster_id        = azurerm_kubernetes_cluster.aks-kubenet.id
#   enable_auto_scaling          = true
#   vm_size                      = "Standard_F4s_v2"
#   node_count                   = 1
#   max_count                    = 2
#   min_count                    = 1
#   max_pods                     = 30
#   orchestrator_version         = "1.19.11"
#   availability_zones           = [3]
#   mode                         = "User"  
#   node_labels                  = { "workload" = "webapp" }
#   # node_taints                  = ["app=webapp:NoSchedule"]
#   vnet_subnet_id               = data.azurerm_subnet.aks-kubenet.id
# }


