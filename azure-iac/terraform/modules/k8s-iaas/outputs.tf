output "master_vm" {
  value = module.vm_master.vm
}

output "master_nic" {
  value = module.vm_master.nic
}

output "worker_vm" {
  value = module.vm_worker.vm
}

output "worker_nic" {
  value = module.vm_worker.nic
}