# Virtual network resource block

resource "azurerm_virtual_network" "my-vnet1" {
  name                = "${local.resource_group_name_perfix}-${var.vnet_name}" #SAP-dev-vnet-default
  address_space       = var.vnet_address
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  tags                = local.common_tags

}