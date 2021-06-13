// Networking 
resource "azurerm_resource_group" "vnet_rg" {
  name     = "${local.res_prefix}-networking"
  location = var.loc.long

tags = {
    "pipeline" = "tf-scaffolding"
}
}

module "networking" {
  source          = "./modules/vnet/"
  res_prefix      = local.res_prefix
  rg_name         = azurerm_resource_group.vnet_rg.name
  loc             = var.loc
  vnet_addr_space = var.vnet_addr_space
  vnet_subnets    = var.vnet_subnets
  tags    = local.tags
}

data "azurerm_subnet" "vnet_gw_subnet" {
  name                 = "GatewaySubnet"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = azurerm_resource_group.vnet_rg.name
  
}

module "gateways" {
  source = "./modules/gateways/"

  res_prefix = module.networking.vnet.name

  prefix          = var.prefix
  env             = var.env
  rg_name         = azurerm_resource_group.vnet_rg.name
  loc             = var.loc
  gw_p2s_pub_cert = file("./files/p2s_pub_cert")

  gw_subnet_id  = data.azurerm_subnet.vnet_gw_subnet.id
  gw_addr_space = ["10.100.100.0/24"]
  tags = local.tags
}

resource "azurerm_private_dns_zone" "pvt_dns" {
  name                = "${var.prefix}.io"
  resource_group_name = azurerm_resource_group.vnet_rg.name  
}

resource "azurerm_private_dns_zone_virtual_network_link" "pvt_dns_vnet_link" {
  name                  = local.res_prefix
  resource_group_name   = azurerm_resource_group.vnet_rg.name
  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns.name
  virtual_network_id    = module.networking.vnet.id
  registration_enabled  = true
  tags = local.tags
}
