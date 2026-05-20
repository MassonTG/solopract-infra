# 1. Provider
provider "vsphere" {
  user                 = var.vsphere_user
  password             = var.vsphere_password
  vsphere_server       = var.vsphere_server
  allow_unverified_ssl = true
}

# 2. Data sources — знайти існуючі ресурси
data "vsphere_datacenter" "dc" {
  name = "vCD-Test"
}

data "vsphere_host" "host" {
  name          = "10.100.0.100"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_datastore" "ds" {
  name          = "datastore1"
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "net" {
  name          = "VM Network"  # назва мережі
  datacenter_id = data.vsphere_datacenter.dc.id
}

# 3. Resource — створити VM
resource "vsphere_virtual_machine" "k8s_master" {
  name             = "k8s-master"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2  # скільки CPU
  memory   = 8192  # скільки RAM в МБ

  network_interface {
    network_id = data.vsphere_network.net.id
  }

  disk {
    label = "disk0"
    size  = 30  # розмір диску в ГБ
  }
}
resource "vsphere_virtual_machine" "gitlab" {
  name             = "k8s-gitlab"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 4  # скільки CPU
  memory   = 8192  # скільки RAM в МБ

  network_interface {
    network_id = data.vsphere_network.net.id
  }

  disk {
    label = "disk0"
    size  = 30  # розмір диску в ГБ
  }
}
resource "vsphere_virtual_machine" "k8s_worker" {
  name             = "k8s-worker"
  resource_pool_id = data.vsphere_host.host.resource_pool_id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2  # скільки CPU
  memory   = 8192  # скільки RAM в МБ

  network_interface {
    network_id = data.vsphere_network.net.id
  }

  disk {
    label = "disk0"
    size  = 30  # розмір диску в ГБ
  }
}