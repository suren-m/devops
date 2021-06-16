output "cluster" {
  value = azurerm_kubernetes_cluster.aks
}

output "cluster_basicuserpool" {
  value = azurerm_kubernetes_cluster_node_pool.basicuserpool
 
}

output "cluster_premiumuserpool" {
  value = azurerm_kubernetes_cluster_node_pool.premiumuserpool
 
}

 