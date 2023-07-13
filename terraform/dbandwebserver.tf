###################### Webserver ######################
resource "azurerm_linux_virtual_machine" "webserver" {
  depends_on = [ azurerm_windows_virtual_machine.windowsserver ]
  name                  = "webserver-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resourcegroup.name
  network_interface_ids = [azurerm_network_interface.webserver-nic1.id]
  size                  = "Standard_B2s"

  os_disk {
    name                 = "OSDisk-webserver-vm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "webserver-vm"
  admin_username                  = var.adminusername
  admin_password                  = var.adminpassword
  custom_data                     = base64encode(data.template_file.webserver.rendered)
  disable_password_authentication = false

  tags = {}
}

resource "null_resource" "copy-cert-file-web" {
  depends_on = [ azurerm_linux_virtual_machine.webserver ]

  connection {
    type     = "ssh"
    host     = azurerm_public_ip.webserverpublicip.ip_address
    user     = var.adminusername
    password = var.adminpassword
  }

  provisioner "file" {
    source      = "./ems_ssl_certificates/Fortinet_Cloud_Demo_CA.crt"
    destination = "/tmp/Fortinet_Cloud_Demo_CA.crt"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/Fortinet_Cloud_Demo_CA.crt /usr/local/share/ca-certificates/",
      "sudo update-ca-certificates",
    ]
  }

}

###################### API Server ######################
resource "azurerm_linux_virtual_machine" "apiserver" {
    depends_on = [ azurerm_windows_virtual_machine.windowsserver ]
  name                  = "apiserver-vm"
  location              = var.location
  resource_group_name   = azurerm_resource_group.resourcegroup.name
  network_interface_ids = [azurerm_network_interface.apiserver-nic1.id]
  size                  = "Standard_B2s"

  os_disk {
    name                 = "OSDisk-apiserver-vm"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  computer_name                   = "apiserver-vm"
  admin_username                  = var.adminusername
  admin_password                  = var.adminpassword
  custom_data                     = base64encode(data.template_file.webserver.rendered)
  disable_password_authentication = false

  tags = {}

}

resource "null_resource" "copy-cert-file-db" {
  depends_on = [ azurerm_linux_virtual_machine.apiserver ]

  connection {
    type     = "ssh"
    host     = azurerm_public_ip.apiserverpublicip.ip_address
    user     = var.adminusername
    password = var.adminpassword
  }

  provisioner "file" {
    source      = "./ems_ssl_certificates/Fortinet_Cloud_Demo_CA.crt"
    destination = "/tmp/Fortinet_Cloud_Demo_CA.crt"
  }

  provisioner "file" {
  source      = "./scripts/main.py"
  destination = "/home/cloudteam/main.py"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cp /tmp/Fortinet_Cloud_Demo_CA.crt /usr/local/share/ca-certificates/",
      "sudo update-ca-certificates",
    ]
  }

}