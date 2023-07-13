//############# FortiWeb VM ###########

resource "azurerm_virtual_machine" "fwebvm" {
  zones                        = null
  name                         = "fwebvm"
  location                     = var.location
  resource_group_name          = azurerm_resource_group.resourcegroup.name
  network_interface_ids        = [azurerm_network_interface.fweb-nic1.id, azurerm_network_interface.fweb-nic2.id]
  primary_network_interface_id = azurerm_network_interface.fweb-nic1.id
  vm_size                      = var.size

  delete_os_disk_on_termination    = true
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = var.publisher
    offer     = var.fweboffer
    sku       = var.sku
    version   = var.fwebversion
  }

  plan {
    name      = var.sku
    publisher = var.publisher
    product   = var.fweboffer
  }

  storage_os_disk {
    name              = "disk_os_fweb"
    caching           = "ReadWrite"
    managed_disk_type = "Premium_LRS"
    create_option     = "FromImage"
  }

  # Log data disks
  storage_data_disk {
    name              = "disk_data_fweb"
    managed_disk_type = "Standard_LRS"
    create_option     = "Empty"
    lun               = 0
    disk_size_gb      = "30"
  }

  os_profile {
    computer_name  = "fwebvm"
    admin_username = var.adminusername
    admin_password = var.adminpassword
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  boot_diagnostics {
    enabled     = true
    storage_uri = azurerm_storage_account.fwebstorageaccount.primary_blob_endpoint
  }

  tags = {
    environment = "CloudTeam QBR"
  }
  
}

# data "template_file" "fweb_custom_data" {
#   template = file("${path.module}/scripts/customdatafweb.txt")

#   vars = {
#     fweb_vm_name        = "fwebvm"
#     fweb_flex_license   = data.fortiflexvm_groups_nexttoken.fweb_free_token.vms.0.token
#     # fweb_username       = var.adminusername
#     # fweb_password       = var.adminpassword
#     # fweb_ipaddr         = azurerm_network_interface.fweb-nic1.private_ip_address
#     # fweb_mask           = azurerm_subnet.external.address_prefixes[0]
#   }
# }