output "vnet_gw_pub_ip" {
  value     = azurerm_public_ip.vnet_gw_pub_ip
  sensitive = true
}

output "vnet_gw" {
  value = azurerm_virtual_network_gateway.vnet_gw
}
