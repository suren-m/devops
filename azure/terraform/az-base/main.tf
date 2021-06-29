// resource prefix
// locals will only be visible to root module, so using variables here

locals {
  res_prefix                   = terraform.workspace == "default" ? "${var.prefix}-${var.loc.short}" : "${terraform.workspace}-${var.prefix}-${var.loc.short}"
  alphanumeric_only_res_prefix = terraform.workspace == "default" ? "${var.prefix}${var.loc.short}" : "${terraform.workspace}${var.prefix}${var.loc.short}"
  tags = {
    res_prefix = "${local.res_prefix}"  
    tf_workspace = "${terraform.workspace}"
    environment = "base"
    pipeline = "tf-scaffolding"
  }
}

resource "azurerm_resource_group" "scaffolding" {
  name     = "${local.res_prefix}-scaffolding"
  location = var.loc.long

  tags = local.tags
}
