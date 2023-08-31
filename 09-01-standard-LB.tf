# Create public ip for Load balancer

resource "azurerm_public_ip" "web_slbip" {
  name                = "${local.resource_group_name_perfix}-webvm-pip"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags

}



resource "azurerm_lb" "web-lb" {
  name                = "${local.resource_group_name_perfix}-web-lb"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard"
  frontend_ip_configuration {
    name                 = "web-lb-pip"
    public_ip_address_id = azurerm_public_ip.web_slbip.id
  }
}

# Create Backend pool for LB

resource "azurerm_lb_backend_address_pool" "web-lb-pool" {
  name            = "web-backed"
  loadbalancer_id = azurerm_lb.web-lb.id
}

# Create health probe for LB

resource "azurerm_lb_probe" "web_lb_probe" {
  name            = "tcp-probe"
  protocol        = "Tcp"
  port            = 80
  loadbalancer_id = azurerm_lb.web-lb.id
  #resource_group_name = azurerm_resource_group.rg.name

}

# Create LB rule

resource "azurerm_lb_rule" "web_lb_rule_1" {
  name                           = "web-slb-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = azurerm_lb.web-lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = ["${azurerm_lb_backend_address_pool.web-lb-pool.id}"]
  probe_id                       = azurerm_lb_probe.web_lb_probe.id
  loadbalancer_id                = azurerm_lb.web-lb.id
  #resource_group_name = azurerm_resource_group.rg.name

}

# Associate Network Interface to Load Balancer

/*
resource "azurerm_network_interface_backend_address_pool_association" "web_nic_lb_assocate" {
    count = var.web_linuxvm_instance_count
    network_interface_id = element(azurerm_network_interface.web_linux_nic[*].id, count.index)
    ip_configuration_name = azurerm_network_interface.web_linux_nic[count.index].ip_configuration[0].name
    backend_address_pool_id = azurerm_lb_backend_address_pool.web-lb-pool.id
  
}
*/