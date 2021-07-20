// Networking 
module "networking" {
  source          = "../modules/vnet/"
  res_prefix      = local.res_prefix
  rg_name         = azurerm_resource_group.base.name
  loc             = var.loc
  vnet_addr_space = var.vnet_addr_space
  vnet_subnets    = var.vnet_subnets
  tags            = local.tags
}



resource "azurerm_private_dns_zone" "pvt_dns" {
  name                = "${var.prefix}.io"
  resource_group_name = azurerm_resource_group.base.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pvt_dns_vnet_link" {
  name                  = local.res_prefix
  resource_group_name   = azurerm_resource_group.base.name
  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns.name
  virtual_network_id    = module.networking.vnet.id
  registration_enabled  = true
  tags                  = local.tags
}
