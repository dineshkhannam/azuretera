# Create Private DNS Zones

resource "azurerm_private_dns_zone" "private_dns_zone" {
  name = "dineshkhanna.co.in"
  resource_group_name = azurerm_resource_group.rg.name
}

# Assoicate Private DNS to Vnet

resource "azurerm_private_dns_zone_virtual_network_link" "private_dns_zone_vnet_assocaite" {
    name = "${local.resource_group_name_perfix}-private-dns-zone-vnet-assoicate"
    resource_group_name = azurerm_resource_group.rg.name
    private_dns_zone_name = azurerm_private_dns_zone.private_dns_zone.name
    virtual_network_id = azurerm_virtual_network.my-vnet1.id
  
}

# Internal load balancer DNS A Record

resource "azurerm_private_dns_a_record" "app_lb_dns_record" {
    depends_on = [ azurerm_lb.app_lb ]
    name = "applb"
    zone_name = azurerm_private_dns_zone.private_dns_zone.name
    resource_group_name = azurerm_resource_group.rg.name
    ttl = 300
    records = [ "${azurerm_lb.app_lb.frontend_ip_configuration[0].private_ip_address}" ]
  
}