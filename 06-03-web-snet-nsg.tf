# resource for Web Subnet block 

resource "azurerm_subnet" "web-subnet" {
  name                 = "${azurerm_virtual_network.my-vnet1.name}-${var.web_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my-vnet1.name
  address_prefixes     = var.web_subnet_address
}

# NSG for Web subnet 

resource "azurerm_network_security_group" "web-nsg" {
  name                = "${azurerm_subnet.web-subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# associate nsg with web-subnet

resource "azurerm_subnet_network_security_group_association" "web-subnet-nsg-associate" {
  depends_on                = [azurerm_network_security_rule.web_subnet_inbound]
  subnet_id                 = azurerm_subnet.web-subnet.id
  network_security_group_id = azurerm_network_security_group.web-nsg.id

}

# NSG rules

locals {
  web_inbound_ports_map = {
    "100" : "80"
    "110" : "443"
    "120" : "22"
  }
}


resource "azurerm_network_security_rule" "web_subnet_inbound" {

  for_each                    = local.web_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.web-nsg.name
}