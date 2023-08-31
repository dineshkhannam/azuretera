# Create public ip for NAT
resource "azurerm_public_ip" "natgw_pip" {
  name                = "${local.resource_group_name_perfix}-natgw-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"

}

# Create NAT Gateway

resource "azurerm_nat_gateway" "natgw" {
  name                = "app-natgw"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "Standard"

}

# Assoicate Public ip to NAT Gateway

resource "azurerm_nat_gateway_public_ip_association" "natgw_pip_associate" {
  nat_gateway_id       = azurerm_nat_gateway.natgw.id
  public_ip_address_id = azurerm_public_ip.natgw_pip.id

}

# Assoicate AppSubnet and NAT Gateway

resource "azurerm_subnet_nat_gateway_association" "natgw_appsubnet_associate" {
  subnet_id      = azurerm_subnet.app-subnet.id
  nat_gateway_id = azurerm_nat_gateway.natgw.id

}