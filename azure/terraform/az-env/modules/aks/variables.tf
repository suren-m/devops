variable "aks_cluster_name" {
  type = string
}

variable "res_prefix" {}

variable "loc" {}

variable "rg_name" {}

variable "kubernetes_version" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "default_pool" {
  type = map(any)
}

variable "user_pool" {
  type = map(any)
}

variable "node_labels" {
  type = map(any)
  default = {
    "purpose"     = "system_workloads"
    "provisioner" = "terraform"
  }
}

variable "user_workloads_node_labels" {
  type = map(any)
  default = {
    "purpose"     = "user_workloads"
    "provisioner" = "terraform"
  }
}

variable "vnet_subnet_id" {
  type = string
}

variable "network_profile" {
  type = map(any)
}

variable "log_analytics_workspace_id" {
  type = string
}
