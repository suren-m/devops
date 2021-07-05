output "cluster" {
  value = azurerm_kubernetes_cluster.aks
}

output "cluster_userpool" {
  value = azurerm_kubernetes_cluster_node_pool.userpool
}