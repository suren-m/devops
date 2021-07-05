module "vm_master" {
  source     = "../../modules/vm/"
  res_prefix = var.res_prefix
  loc        = var.loc
  rg_name    = var.rg_name  
  
  vm_prefix = "${var.cluster_prefix}-master"
  vm_count  = var.master_count

  subnet_id = var.subnet_id

  vm_size = var.vm_size

  vm_admin    = var.vm_admin
  pub_key = var.pub_key
  tags = var.tags
}

module "vm_worker" {
  source     = "../../modules/vm/"
  res_prefix = var.res_prefix  
  loc        = var.loc
  rg_name    = var.rg_name

  vm_prefix = "${var.cluster_prefix}-worker"
  vm_count  = var.worker_count

  subnet_id = var.subnet_id

  vm_size = var.vm_size


  vm_admin    = var.vm_admin
  pub_key = var.pub_key
  tags = var.tags
}

