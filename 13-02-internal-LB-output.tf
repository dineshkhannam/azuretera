
output "app_lb_private_ip_address" {
  description = "Load balancer private ip address"
  value       = [azurerm_lb.app_lb.private_ip_address]
}

output "app_lb_id" {
  description = "Load balancer id"
  value       = azurerm_lb.app_lb
}

output "app_lb_frontend_ip_configuration" {
  description = "LB frontend ip configurtion"
  value       = [azurerm_lb.app_lb.frontend_ip_configuration]
}

