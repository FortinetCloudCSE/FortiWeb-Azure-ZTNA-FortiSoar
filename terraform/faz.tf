resource "azurerm_virtual_machine" "fazvm" {
  name                         = "fortianalyzer-vm"
  location                     = azurerm_resource_group.resourcegroup.location
  resource_group_name          = azurerm_resource_group.resourcegroup.name
  network_interface_ids        = [azurerm_network_interface.fortianalyzer-nic1.id]
  primary_network_interface_id = azurerm_network_interface.fortianalyzer-nic1.id
  vm_size                      = var.faz_vmsize
  delete_os_disk_on_termination = true
  delete_data_disks_on_termination = true

  identity {
    type = "SystemAssigned"
  }

  storage_image_reference {
    publisher = "fortinet"
    offer     = "fortinet-fortianalyzer"
    sku       = var.faz_image_sku
    version   = var.faz_version
  }

  plan {
    publisher = "fortinet"
    product   = "fortinet-fortianalyzer"
    name      = var.faz_image_sku
  }

  storage_os_disk {
    name              = "fortianalyzer-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  storage_data_disk {
    name              = "fortianalyzer-datadisk"
    caching           = "ReadWrite"
    create_option     = "Empty"
    managed_disk_type = "Standard_LRS"
    disk_size_gb      = 50
    lun               = 0
  }

  os_profile {
    computer_name  = "fortianalyzer-vm"
    admin_username = var.adminusername
    admin_password = var.adminpassword
    custom_data    = data.template_file.faz_custom_data.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  tags = {}
}

data "template_file" "faz_custom_data" {
  template = file("${path.module}/scripts/customdata.tpl")

  vars = {
    faz_vm_name        = "fortianalyzer-vm"
    faz_flex-license   = data.fortiflexvm_groups_nexttoken.faz_free_token.vms.0.token
    faz_username       = var.adminusername
    faz_password       = var.adminpassword
    faz_ipaddr         = azurerm_network_interface.fortianalyzer-nic1.private_ip_address
    faz_mask           = azurerm_subnet.external.address_prefixes[0]
  }
}

resource "time_sleep" "delay_80s" {
  depends_on = [azurerm_virtual_machine.fazvm ]
  create_duration = "80s"
}

resource "null_resource" "setup_soar_container" {
  depends_on = [time_sleep.delay_80s]
  provisioner "local-exec" {
    command = "python3 analyzer_api.py ${azurerm_public_ip.fortianalyzerpublicip.ip_address} ${var.adminusername} ${var.adminpassword}"
    working_dir = "${path.module}/scripts"
  }
}