# resource for DB Subnet block 

resource "azurerm_subnet" "db-subnet" {
  name                 = "${azurerm_virtual_network.my-vnet1.name}-${var.db_subnet_name}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my-vnet1.name
  address_prefixes     = var.db_subnet_address
}

# NSG for db subnet 

resource "azurerm_network_security_group" "db-nsg" {
  name                = "${azurerm_subnet.db-subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# associate nsg with app-subnet

resource "azurerm_subnet_network_security_group_association" "db-subnet-nsg-associate" {
  depends_on                = [azurerm_network_security_rule.db_subnet_inbound]
  subnet_id                 = azurerm_subnet.db-subnet.id
  network_security_group_id = azurerm_network_security_group.db-nsg.id

}

# NSG rules

locals {
  db_inbound_ports_map = {
    "100" : "3306"
    "110" : "1433"
    "120" : "22"
    "130" : "5432"
  }
}


resource "azurerm_network_security_rule" "db_subnet_inbound" {

  for_each                    = local.db_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.db-nsg.name
}