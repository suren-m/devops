resource "azurerm_public_ip" "vnet_gw_pub_ip" {
  name                = "${var.res_prefix}-gw-pub-ip"
  location            = var.loc.long
  resource_group_name = var.rg_name

  allocation_method = "Dynamic"
  tags              = var.tags
}

resource "azurerm_virtual_network_gateway" "vnet_gw" {
  name                = "${var.res_prefix}-gw"
  location            = var.loc.long
  resource_group_name = var.rg_name

  type     = "Vpn"
  vpn_type = "RouteBased"

  active_active = false
  enable_bgp    = false
  sku           = "Basic"
  tags          = var.tags

  ip_configuration {
    name                          = "vnetGatewayConfig"
    public_ip_address_id          = azurerm_public_ip.vnet_gw_pub_ip.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = var.gw_subnet_id
  }

  vpn_client_configuration {
    address_space = var.gw_addr_space
    root_certificate {
      name             = "P2S_PUB_CERT"
      public_cert_data = var.gw_p2s_pub_cert
    }
  }
}