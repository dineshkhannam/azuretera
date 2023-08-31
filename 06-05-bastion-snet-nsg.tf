# resource for bastion Subnet block 

resource "azurerm_subnet" "bastion-subnet" {
  name                 = "${azurerm_virtual_network.my-vnet1.name}-${var.bastion_subnet}"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my-vnet1.name
  address_prefixes     = var.bastion_subnet_address
}

# NSG for bastion subnet 

resource "azurerm_network_security_group" "bastion-nsg" {
  name                = "${azurerm_subnet.bastion-subnet.name}-nsg"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

# associate nsg with bastion-subnet

resource "azurerm_subnet_network_security_group_association" "bastion-subnet-nsg-associate" {
  depends_on                = [azurerm_network_security_rule.bastion_subnet_inbound]
  subnet_id                 = azurerm_subnet.bastion-subnet.id
  network_security_group_id = azurerm_network_security_group.bastion-nsg.id

}

# NSG rules

locals {
  bastion_inbound_ports_map = {
    "100" : "22"
    "110" : "3389"
  }
}


resource "azurerm_network_security_rule" "bastion_subnet_inbound" {

  for_each                    = local.bastion_inbound_ports_map
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
  network_security_group_name = azurerm_network_security_group.bastion-nsg.name
}