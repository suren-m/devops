resource "azurerm_network_security_group" "default_nsg" {
  name                = var.res_prefix
  location            = var.loc.long
  resource_group_name = var.rg_name
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.res_prefix
  location            = var.loc.long
  resource_group_name = var.rg_name
  address_space       = var.vnet_addr_space

  dynamic "subnet" {
    for_each = [for s in var.vnet_subnets : s if s.default_nsg == true]
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.cidr[0]
      security_group = azurerm_network_security_group.default_nsg.id
    }
  }

  dynamic "subnet" {
    for_each = [for s in var.vnet_subnets : s if s.default_nsg == false]
    content {
      name           = subnet.value.name
      address_prefix = subnet.value.cidr[0]
    }
  }

  tags = var.tags

}

# resource "azurerm_subnet" "subnets" {
#   count = length(var.vnet_subnets)
#   name                 = "${var.prefix}-${var.env}-${var.loc.short}-${lookup(var.vnet_subnets[count.index], "name")}"
#   resource_group_name = var.rg_name
#   virtual_network_name = azurerm_virtual_network.vnet.name
#   address_prefixes     = lookup(var.vnet_subnets[count.index], "cidr")
# }

# resource "azurerm_subnet_network_security_group_association" "subnet_security_group_association" {   
#   subnet_id                 = ..
#   network_security_group_id = azurerm_network_security_group.example.id
# }
