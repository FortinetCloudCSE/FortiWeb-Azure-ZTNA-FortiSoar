resource "azurerm_windows_virtual_machine" "windowsclient" {
  name                = "windowsclient"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  size                = "Standard_DS1_v2"
  admin_username      = var.adminusername
  admin_password      = var.adminpassword
  custom_data         = filebase64("./${var.cloudinitclient_file}")

  network_interface_ids = [
    azurerm_network_interface.windowsclient-nic1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsDesktop"
    offer     = "Windows-10"
    sku       = "win10-22h2-pro-g2"
    version   = "latest"
  }
}

  
resource "azurerm_virtual_machine_extension" "cloudinitclient" {
  name                 = "cloudinitclient"
  virtual_machine_id = azurerm_windows_virtual_machine.windowsclient.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/forticlientinstall.ps1; c:/azuredata/forticlientinstall.ps1\""
    }
    SETTINGS
}


resource "null_resource" "copy-winclient-file" {
  depends_on = [ azurerm_windows_virtual_machine.windowsclient , azurerm_virtual_machine_extension.cloudinitclient ]

  connection {
    type     = "winrm"
    host     = azurerm_windows_virtual_machine.windowsserver.public_ip_address
    user     = var.adminusername
    password = var.adminpassword
  }

  provisioner "file" {
    source      = "ems_ssl_certificates/"
    destination = "C:/Users/cloudteam/Desktop/ems_ssl_certificates"
  }

  provisioner "remote-exec" {
      inline = [         
          "powershell.exe -ExecutionPolicy Bypass -File C:/Users/Cloudteam/Desktop/ems_ssl_certificates/install_certificates.ps1"
      ]
  }

}
