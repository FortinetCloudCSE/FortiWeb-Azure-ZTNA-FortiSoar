variable "resourcegroup" {
  description = "resource_group_name"
  type        = string
}

variable "location" {
  description = "resource_group_location"
  type        = string
}

variable "publicip" {
  description = "public_ip_name"
  type        = string
  default     = "fwb-pip"
}

variable "vnetname" {
  description = "virtual_network_name"
  type        = string
  default     = "lab-vnet"
}

variable "securitygrpname" {
  description = "security_group_name"
  type        = string
  default     = "fwb-sg"
}

variable "size" {
  description = "vm_size"
  type        = string
  default     = "Standard_F2s"
}

variable "publisher" {
  description = "vm_publisher"
  type        = string
  default     = "fortinet"
}

variable "fweboffer" {
  description = "vm_offer"
  type        = string
  default     = "fortinet_fortiweb-vm_v5"
}

variable "sku" {
  description = "vm_sku"
  type        = string
  default     = "fortinet_fw-vm"
}


variable "fwebversion" {
  description = "vm_version"
  type        = string
  default     = "7.2.0"
}

variable "adminusername" {
  description = "admin_username"
  type        = string
  default     = "cloudteam"
} 

variable "adminpassword" {
  description = "admin_password"
  type        = string
  default     = "S3cur3P4ssw0rd123!"
} 


variable "cloudinit_file" {
  description = "cloudinit_file"
  type        = string
  default     = "./scripts/ems_server_install.ps1"
}

variable "cloudinitclient_file" {
  description = "cloudinitclient_file"
  type        = string
  default     = "./scripts/forticlientinstall.ps1"
}



variable "bootstrap-webserver" {
  type    = string
  default = "./scripts/setup_webserver.txt"
}

variable "bootstrap-apiserver" {
  type    = string
  default = "./scripts/setup_apiserver.txt"
}


################# FortiAnalyzer Variables #################
variable "faz_vmsize" {
  type    = string
  default = "Standard_DS4_v2"
}

variable "faz_image_sku" {
  type    = string
  default = "fortinet-fortianalyzer"
}

variable "faz_version" {
  type    = string
  default = "latest"
}

variable "faz_username" {
  type    = string
  default = "cloudteam"
}

variable "faz_password" {
  type    = string
  default = "Fortinet123!"
}

variable "faz_new_password" {
  type    = string
  default = "Azureuser123!"
}

################# FortiFlex Variables #################
variable "fortiflex_api_user" {
  type    = string
}

variable "fortiflex_api_password" {
  type    = string
}