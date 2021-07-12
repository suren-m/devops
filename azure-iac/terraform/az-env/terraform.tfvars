// common
base_prefix = "azbase"
base_rg     = "azbase-uks"
prefix      = "azenv"
loc = {
  short = "uks"
  long  = "uk south"
}

// aks
aks_cluster_name   = "azenv"
kubernetes_version = "1.20.7"
aks_vm_size        = "Standard_B2s"
default_pool = {
  init_count = 2
  min_count  = 2
  max_count  = 4
}
user_pool = {
  init_count = 2
  min_count  = 2
  max_count  = 4
}

// k8s iaas 
cluster_prefix = "k8s"
master_count   = 1
worker_count   = 3
vm_size        = "Standard_D2as_v4"