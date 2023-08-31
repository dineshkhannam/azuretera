resource "azurerm_lb" "app_lb" {
  name                = "${local.resource_group_name_perfix}-app-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                          = "app-lb-private-ip"
    subnet_id                     = azurerm_subnet.app-subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address_version    = "IPv4"
    private_ip_address            = "10.0.11.241"
  }
}

# Create LB Backend pool
resource "azurerm_lb_backend_address_pool" "app_lb_backend_address_pool" {
  name            = "app-backend"
  loadbalancer_id = azurerm_lb.app_lb.id

}

# create health probe

resource "azurerm_lb_probe" "app_lb_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.app_lb.id

}



# Create LB rule

resource "azurerm_lb_rule" "app_lb_rule" {
  name     = "app-lb-rule"
  protocol = "Tcp"

  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.app_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = ["${azurerm_lb_backend_address_pool.app_lb_backend_address_pool.id}"]
  probe_id                       = azurerm_lb_probe.app_lb_probe.id
  loadbalancer_id                = azurerm_lb.app_lb.id

}