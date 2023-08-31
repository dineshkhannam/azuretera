output "natgw_id" {
  description = "Azure NAT Gateway ID"
  value       = azurerm_nat_gateway.natgw.id
}

output "nat_gw_pip" {
  description = "Azure NAT gateway public ip"
  value       = azurerm_public_ip.natgw_pip.ip_address

}