resource "azurerm_ssh_public_key" "example" {
  name                = "example"
  resource_group_name = "example"
  location            = "West Europe"
  public_key          = file("~/.ssh/id_rsa.pub")
}