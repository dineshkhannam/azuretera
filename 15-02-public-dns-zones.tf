# Datasource: DNS Record
data "azurerm_dns_zone" "dns_zone" {
    name = "dineshkhanna.co.in"
    resource_group_name = "dns-rg"
}

# Add root Record for DNS Zone
resource "azurerm_dns_a_record" "dns_record" {
    depends_on = [ azurerm_lb.web-lb ]
    name = "@"
    zone_name = data.azurerm_dns_zone.dns_zone.name
    resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
    ttl = 300
    target_resource_id = azurerm_public_ip.web_slbip.id
  
}

# Add www record set in DNS zone

resource "azurerm_dns_a_record" "dns_record_www" {
    depends_on = [ azurerm_lb.web-lb ]
    name = "www"
    zone_name = data.azurerm_dns_zone.dns_zone.name
    resource_group_name = data.azurerm_dns_zone.dns_zone.resource_group_name
    ttl = 300
    target_resource_id = azurerm_public_ip.web_slbip.id
  
}

