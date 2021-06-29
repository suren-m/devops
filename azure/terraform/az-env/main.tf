// resource prefix
// locals will only be visible to root module, so using variables here

locals {
  base_prefix  = terraform.workspace == "default" ? "${var.base_prefix}-${var.loc.short}" : "${terraform.workspace}-${var.base_prefix}-${var.loc.short}"
  alphanumeric_only_base_prefix = terraform.workspace == "default" ? "${var.base_prefix}${var.loc.short}" : "${terraform.workspace}${var.base_prefix}${var.loc.short}" 
  base_rg = "${var.base_rg}"

  res_prefix                   = terraform.workspace == "default" ? "${var.prefix}-${var.loc.short}" : "${terraform.workspace}-${var.prefix}-${var.loc.short}"
  alphanumeric_only_res_prefix = terraform.workspace == "default" ? "${var.prefix}${var.loc.short}" : "${terraform.workspace}${var.prefix}${var.loc.short}"

  tags = {
    res_prefix = "${local.res_prefix}"  
    tf_workspace = "${terraform.workspace}"
    environment = "az-env"
    pipeline = "tf-az-env"
  }
}



# utils
data "http" "tf_check" {
  url = "https://checkpoint-api.hashicorp.com/v1/check/terraform"

  request_headers = {
    Accept = "application/json"
  }
}

# resource "azurerm_resource_group" "live_demo_rg" {
#   name     = "${local.res_prefix}-livedemo-rg"
#   location = var.loc.long
# }




