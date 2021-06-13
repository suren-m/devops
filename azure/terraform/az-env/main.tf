// resource prefix
// locals will only be visible to root module, so using variables here

locals {
  res_prefix                   = terraform.workspace == "default" ? "${var.prefix}-${var.loc.short}" : "${terraform.workspace}-${var.prefix}-${var.loc.short}"
  alphanumeric_only_res_prefix = terraform.workspace == "default" ? "${var.prefix}${var.loc.short}" : "${terraform.workspace}${var.prefix}${var.loc.short}"
}

# utils
data "http" "tf_check" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  request_headers = {
    Accept = "application/json"
  }
}

resource "azurerm_resource_group" "live_demo_rg" {
  name     = "${local.res_prefix}-livedemo-rg"
  location = var.loc.long
}




