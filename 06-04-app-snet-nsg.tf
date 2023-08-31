

# resource for app Subnet block 

resource "azurerm_subnet" "app-subnet" {
  name                 = "${azurerm_virtual_network.my-vnet1.name}-${var.app_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my-vnet1.name
  address_prefixes     = var.app_subnet_address
}

# NSG for app subnet 

resource "azurerm_network_security_group" "app-nsg" {
  name                = "${azurerm_subnet.app-subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# associate nsg with app-subnet

resource "azurerm_subnet_network_security_group_association" "app-subnet-nsg-associate" {
  depends_on                = [azurerm_network_security_rule.app_subnet_inbound]
  subnet_id                 = azurerm_subnet.app-subnet.id
  network_security_group_id = azurerm_network_security_group.app-nsg.id

}

# NSG rules

locals {
  app_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"
    "130" : "8080"
  }
}


resource "azurerm_network_security_rule" "app_subnet_inbound" {

  for_each                    = local.app_inbound_ports_map
  name                        = "Rule-Port-${each.value}"
  priority                    = each.key
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = each.value
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.rg.name
  network_security_group_name = azurerm_network_security_group.app-nsg.name
}

