###################### Generate Random String ######################
resource "random_string" "random" {
  length           = 6
  special          = false
  lower            = true
  upper            = false
}
  //############# Resource Group ###########
resource "azurerm_resource_group" "resourcegroup" {
  name     = var.resourcegroup
  location = var.location
}

//############# Public IP ###########
resource "azurerm_public_ip" "fwebpublicip" {
  name                = "publicip-fweb"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  allocation_method   = "Static"

}

resource "azurerm_public_ip" "winserverpublicip" {
  name                = "publicip-windowsserver"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  allocation_method   = "Static"

}  

resource "azurerm_public_ip" "windowsclientpublicip" {
  name                = "publicip-windowsclient"
  resource_group_name = azurerm_resource_group.resourcegroup.name
  location            = azurerm_resource_group.resourcegroup.location
  allocation_method   = "Static"

}  


resource "azurerm_public_ip" "fortianalyzerpublicip" {
  name                = "fortianalyzer-pip"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method   = "Static"

}

resource "azurerm_public_ip" "apiserverpublicip" {
  name                = "apiserver-pip"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method   = "Static"

}

resource "azurerm_public_ip" "webserverpublicip" {
  name                = "webserver-pip"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  allocation_method   = "Static"

}

###################### Render Boostrap Templates ######################
data "template_file" "webserver" {
  template = file(var.bootstrap-webserver)
  vars     = {}
}

data "template_file" "apiserver" {
  template = file(var.bootstrap-apiserver)
  vars = {}
}

//############# Virtual Network ###########
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnetname
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name
  address_space       = ["10.0.0.0/22"]
}

//############# External Subnet ###########
resource "azurerm_subnet" "external" {
  name                 = "external"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.0/26"]
}

//############# Internal Subnet ###########
resource "azurerm_subnet" "internal" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.0.64/26"]
}

//############# Protected Subnet ###########
resource "azurerm_subnet" "application" {
  name                 = "application"
  resource_group_name  = azurerm_resource_group.resourcegroup.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}


//############# FortiWeb Network Interface - External ###########
resource "azurerm_network_interface" "fweb-nic1" {
  name                = "fweb-nic1"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "fweb-external"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.4"

  public_ip_address_id = "${azurerm_public_ip.fwebpublicip.id}"
  }
  depends_on = [azurerm_public_ip.fwebpublicip]
}

//############# FortiWeb Network Interface - Internal ###########
resource "azurerm_network_interface" "fweb-nic2" {
  name                = "fweb-nic2"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "fweb-internal"
    subnet_id                     = azurerm_subnet.internal.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.68"
  }
}

//############# WindowsServer Network Interface ###########
resource "azurerm_network_interface" "windowsserver-nic1" {
  name                = "windowsserver-nic1"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "windowsserver-nic1"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.5"

    public_ip_address_id = "${azurerm_public_ip.winserverpublicip.id}"

  }

  depends_on = [azurerm_public_ip.winserverpublicip]
}

//############# WindowsClient Network Interface ###########
resource "azurerm_network_interface" "windowsclient-nic1" {
  name                = "windowsclient-internal"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "windowsclient-nic1"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.6"
    public_ip_address_id          = azurerm_public_ip.windowsclientpublicip.id
  }
}

//############# WebServer Network Interface ###########
resource "azurerm_network_interface" "webserver-nic1" {
  name                = "webserver-nic1"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "webserver-nic1"
    subnet_id                     = azurerm_subnet.application.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.4"
    public_ip_address_id          = azurerm_public_ip.webserverpublicip.id
  }
}

resource "azurerm_network_interface" "apiserver-nic1" {
  name                = "apiserver-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "api-nic1"
    subnet_id                     = azurerm_subnet.application.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.1.5"
    public_ip_address_id          = azurerm_public_ip.apiserverpublicip.id
  }

}

//############# FAZ Network Interface ###########
resource "azurerm_network_interface" "fortianalyzer-nic1" {
  name                = "fortianalyzer-nic1"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  ip_configuration {
    name                          = "faz-nic1"
    subnet_id                     = azurerm_subnet.external.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.0.7"
    public_ip_address_id          = azurerm_public_ip.fortianalyzerpublicip.id
  }

}

//############# Azure Storage Account ###########
resource "azurerm_storage_account" "fwebstorageaccount" {
  name                     = "fwebstorageaccount${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.resourcegroup.name
  location                 = azurerm_resource_group.resourcegroup.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}


//############# Security Group ###########
resource "azurerm_network_security_group" "securitygroup" {
  name                = var.securitygrpname
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  security_rule {
    name                       = "all_inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "all_outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

resource "azurerm_network_security_group" "webserver_nsg" {
  name                = "webserver-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_http"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "All-OUT"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {}
}

resource "azurerm_network_security_group" "apiserver_nsg" {
  name                = "apiserver-nsg"
  location            = var.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  security_rule {
    name                       = "allow_ssh"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_8000"
    priority                   = 1002
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8000"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }


  security_rule {
    name                       = "allow_http"
    priority                   = 1003
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "allow_https"
    priority                   = 1004
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }  

  security_rule {
    name                       = "All-OUT"
    priority                   = 1001
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

}

################# Network Security Group Association #################
resource "azurerm_network_interface_security_group_association" "connect_webserver_nsg" {
  network_interface_id      = azurerm_network_interface.webserver-nic1.id
  network_security_group_id = azurerm_network_security_group.webserver_nsg.id
}

resource "azurerm_network_interface_security_group_association" "connect_apiserver_nsg" {
  network_interface_id      = azurerm_network_interface.apiserver-nic1.id
  network_security_group_id = azurerm_network_security_group.apiserver_nsg.id
}


################# Azure Route Table #################
resource "azurerm_route_table" "fweb_rt" {
  name                = "fortiweb_route_table"
  location            = azurerm_resource_group.resourcegroup.location
  resource_group_name = azurerm_resource_group.resourcegroup.name

  route {
    name                   = "to_vnet_route"
    address_prefix         = "10.0.0.0/22"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = "10.0.0.68"
  }
}

resource "azurerm_subnet_route_table_association" "protected_subnet" {
  subnet_id      = azurerm_subnet.application.id
  route_table_id = azurerm_route_table.fweb_rt.id
}

