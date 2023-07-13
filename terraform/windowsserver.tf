resource "azurerm_windows_virtual_machine" "windowsserver" {
  name                = "windowsserver"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  size                = "Standard_DS2_v2"
  admin_username      = var.adminusername
  admin_password      = var.adminpassword
  custom_data         = filebase64("./${var.cloudinit_file}")

  network_interface_ids = [
    azurerm_network_interface.windowsserver-nic1.id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-datacenter-gensecond"
    version   = "latest"
  }
}

  
resource "azurerm_virtual_machine_extension" "cloudinit" {
  name                 = "cloudinit"
  virtual_machine_id = azurerm_windows_virtual_machine.windowsserver.id
  publisher            = "Microsoft.Compute"
  type                 = "CustomScriptExtension"
  type_handler_version = "1.10"
  settings = <<SETTINGS
    {
        "commandToExecute": "powershell -ExecutionPolicy unrestricted -NoProfile -NonInteractive -command \"cp c:/azuredata/customdata.bin c:/azuredata/srija.ps1; c:/azuredata/srija.ps1\""
    }
    SETTINGS
  
  timeouts {
    create = "60m"
    delete = "2h"
  }
}


resource "null_resource" "copy-winserver-files" {
  depends_on = [ azurerm_windows_virtual_machine.windowsserver, azurerm_virtual_machine_extension.cloudinit ]

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
