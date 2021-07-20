

data "azurerm_subnet" "vnet_gw_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = local.res_prefix
  resource_group_name  = local.res_prefix

}

module "gateways" {
  source = "../modules/gateways/"

  res_prefix = local.res_prefix

  rg_name         = local.res_prefix
  loc             = var.loc
  gw_p2s_pub_cert = file("../files/p2s_pub_cert")

  gw_subnet_id  = data.azurerm_subnet.vnet_gw_subnet.id
  gw_addr_space = ["10.100.100.0/24"]
  tags          = local.tags
}
