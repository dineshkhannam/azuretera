#create nic for web-linux vm 
resource "azurerm_network_interface" "web_linux_nic" {
  count               = var.web_linuxvm_instance_count
  name                = "${local.resource_group_name_perfix}-web-linux-nic-${count.index}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "web-linuix-nic1"
    subnet_id                     = azurerm_subnet.web-subnet.id
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id = azurerm_public_ip.web_linux_pip.id
  }
}

