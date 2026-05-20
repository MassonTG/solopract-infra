output "master_ip" {
  value = vsphere_virtual_machine.k8s_master.default_ip_address
}

output "worker_ip" {
  value = vsphere_virtual_machine.k8s_worker.default_ip_address
}

output "gitlab_ip" {
  value = vsphere_virtual_machine.gitlab.default_ip_address
}