resource "azurerm_storage_account" "sg_acct" {
  // name must be globally unique
  name = "${var.res_prefix}${var.sg_name_suffix}"

  resource_group_name = var.rg_name
  location            = var.loc.long

  account_tier             = "Standard"
  account_replication_type = "ZRS"

  tags = {
    environment = var.env
  }
}

resource "azurerm_storage_container" "blob_containers" {
  count                 = length(var.blob_containers)
  name                  = var.blob_containers[count.index]
  storage_account_name  = azurerm_storage_account.sg_acct.name
  container_access_type = "private"
}