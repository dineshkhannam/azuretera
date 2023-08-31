#Resource group block
resource "azurerm_resource_group" "rg" {
  name     = "${local.resource_group_name_perfix}-${var.resource_group_name}-${random_string.random.id}"
  location = var.resource_group_location
  tags     = local.common_tags

}