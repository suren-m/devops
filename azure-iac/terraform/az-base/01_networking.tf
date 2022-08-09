// Networking 
module "networking" {
  source          = "../modules/vnet/"
  res_prefix      = local.res_prefix
  rg_name         = data.azurerm_resource_group.base.name
  loc             = var.loc
  vnet_addr_space = var.vnet_addr_space
  vnet_subnets    = var.vnet_subnets
  tags            = local.tags
}

resource "azurerm_private_dns_zone" "pvt_dns" {
  name                = "${var.prefix}.io"
  resource_group_name = data.azurerm_resource_group.base.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "pvt_dns_vnet_link" {
  name                  = local.res_prefix
  resource_group_name   = data.azurerm_resource_group.base.name
  private_dns_zone_name = azurerm_private_dns_zone.pvt_dns.name
  virtual_network_id    = module.networking.vnet.id
  registration_enabled  = true
  tags                  = local.tags
}

data "azurerm_subnet" "vm" {
  name                 = "vm"
  virtual_network_name = module.networking.vnet.name
  resource_group_name  = data.azurerm_resource_group.base.name
  depends_on           = [module.networking.vnet]
}

# # imported - ran import and updated terraform.tfvars (subnets added for cloudshell)
# # terraform import azurerm_subnet.cloudshellsubnet /subscriptions/xxx-xxx/resourceGroups/azbase-weu/providers/Microsoft.Network/virtualNetworks/azbase-weu/subnets/cloudshellsubnet
# resource "azurerm_subnet" "cloudshellsubnet" {
#   name = "cloudshellsubnet"
#   resource_group_name = data.azurerm_resource_group.base.name
#   virtual_network_name = module.networking.vnet.name
#     address_prefixes = ["10.0.220.0/26"]
# enforce_private_link_endpoint_network_policies = true
#    service_endpoints = [ "Microsoft.Storage"]
#     delegation {
#           name = "CloudShellDelegation" 

#           service_delegation {
#               actions = [
#                   "Microsoft.Network/virtualNetworks/subnets/action",
#               ]
#               name    = "Microsoft.ContainerInstance/containerGroups"
#           }
#       }


# }
# #terraform import azurerm_subnet.relaysubnet /subscriptions/xxx-xxx/resourceGroups/azbase-weu/providers/Microsoft.Network/virtualNetworks/azbase-weu/subnets/relaysubnet
# resource "azurerm_subnet" "relaysubnet" {
#     name = "relaysubnet"
#   resource_group_name = data.azurerm_resource_group.base.name
#   virtual_network_name = module.networking.vnet.name
#     address_prefixes = ["10.0.221.0/26"]
#     enforce_private_link_endpoint_network_policies = true
# }
# #terraform import azurerm_subnet.storagesubnet /subscriptions/xxx-xxx/resourceGroups/azbase-weu/providers/Microsoft.Network/virtualNetworks/azbase-weu/subnets/storagesubnet
# resource "azurerm_subnet" "storagesubnet" {
#     name = "storagesubnet"
#   resource_group_name = data.azurerm_resource_group.base.name
#   virtual_network_name = module.networking.vnet.name
#   address_prefixes = ["10.0.222.0/26"]
# enforce_private_link_endpoint_network_policies = true
#    service_endpoints = [ "Microsoft.Storage"]
# }