#virutal network outputs

output "virtual_network_name" {
  description = "virtual network name"
  value       = azurerm_virtual_network.my-vnet1.name
}

output "virtual_network_id" {
  description = "virtual network id"
  value       = azurerm_virtual_network.my-vnet1.id
}

# subnet outputs

output "web_subnet_name" {
  description = "web subnet name"
  value       = azurerm_subnet.web-subnet.name
}

output "web_subnet_id" {
  description = "web subnet id"
  value       = azurerm_subnet.web-subnet.id
}


output "web_subnet_nsg_name" {
  description = "webtier subnet nsg name"
  value       = azurerm_network_security_group.web-nsg.name

}

output "web_subnet_nsg_id" {
  description = "webtier subnet nsg id"
  value       = azurerm_network_security_group.web-nsg.id

}

