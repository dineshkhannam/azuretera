# Create Azure Bastion Service Subnet
resource "azurerm_subnet" "bastion_service_snet" {
  name                 = var.bastion_service_subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.my-vnet1.name
  address_prefixes     = var.bastion_service_address_prefixes

}

# Create Azure Public ip for Bastion Service

resource "azurerm_public_ip" "bastion_svc_pip" {
  name                = "${local.resource_group_name_perfix}-bastion-svc-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}


# Create Azure Bastion service host

resource "azurerm_bastion_host" "bastion_host" {
  name                = "${local.resource_group_name_perfix}-bastion-host"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                 = "configure"
    subnet_id            = azurerm_subnet.bastion_service_snet.id
    public_ip_address_id = azurerm_public_ip.bastion_svc_pip.id
  }

}