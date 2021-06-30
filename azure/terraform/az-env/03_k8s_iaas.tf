# //K8s iaas (k8s from scratch on Vms)
# resource "azurerm_resource_group" "k8s_rg" {
#   name     = "${local.res_prefix}-k8s"
#   location = var.loc.long
# }

# module "k8s-iaas" {
#   source     = "../modules/k8s-iaas/"
#   res_prefix = local.res_prefix
  
#   loc     = var.loc
#   rg_name = azurerm_resource_group.k8s_rg.name  

#   cluster_prefix = var.cluster_prefix
#   master_count   = var.master_count
#   worker_count   = var.worker_count

#   subnet_id = data.azurerm_subnet.k8s.id
#   vm_size   = "Standard_D2as_v4"

#   vm_admin    = "suren"
#   pub_key = file("../files/id_rsa.pub") 
#   tags = local.tags
# }