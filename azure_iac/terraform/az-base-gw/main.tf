
locals {
  res_prefix                   = terraform.workspace == "default" ? "${var.prefix}-${var.loc.short}" : "${terraform.workspace}-${var.prefix}-${var.loc.short}"
  alphanumeric_only_res_prefix = terraform.workspace == "default" ? "${var.prefix}${var.loc.short}" : "${terraform.workspace}${var.prefix}${var.loc.short}"
  tags = {
    res_prefix = "${local.res_prefix}"  
    tf_workspace = "${terraform.workspace}"
    environment = "base"
    pipeline = "tf-base"
  }
}

