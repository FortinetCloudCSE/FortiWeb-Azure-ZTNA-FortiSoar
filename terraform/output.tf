###################### Output Webserver ######################
output "webserver_public_ip" {
    value = azurerm_public_ip.webserverpublicip.ip_address
}
output "webserver_private_ip" {
    value = azurerm_network_interface.webserver-nic1.private_ip_address
}

###################### Output APIServer ######################
output "apiserver_public_ip" {
    value = azurerm_public_ip.apiserverpublicip.ip_address
}
output "apiserver_private_ip" {
    value = azurerm_network_interface.apiserver-nic1.private_ip_address
}

###################### Output FortiWeb Information ######################
output "fortiwep_public_ip"{
    value = azurerm_public_ip.fwebpublicip.ip_address
}

###################### Output Windows Client Information ######################
output "windows_client_public_ip" {
    value = azurerm_public_ip.windowsclientpublicip.ip_address

}

###################### Output FortiClient EMS Information ######################
output "forticlient_ems_server_public_ip"{
    value = azurerm_public_ip.winserverpublicip.ip_address

}

###################### Output FortiAnalyzer Information ######################
output "fortianalyzer_public_ip"{
    value = azurerm_public_ip.fortianalyzerpublicip.ip_address

}
output "fortianalyzer_private_ip"{
    value = azurerm_network_interface.fortianalyzer-nic1.private_ip_address

}

###################### Output Login Credentials Information ######################
output "all_username" {
    value = var.adminusername
}
output "all_password" {
    value = var.adminpassword
}