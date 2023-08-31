# Create Storage Account

resource "azurerm_storage_account" "storage_account" {
  name                = "${var.storage_account_name}${random_string.random.id}"
  resource_group_name = azurerm_resource_group.rg.name

  location                 = var.resource_group_location
 
  account_replication_type = var.storage_account_replication_type
  account_kind             = var.storage_account_kind
  account_tier             = var.storage_account_tier

  static_website {
    index_document     = var.storage_website_index_document
    error_404_document = var.storage_website_error_document

  }

}

# Httpd file container

resource "azurerm_storage_container" "httpd_file_container" {
  name                  = "httpd-files-container"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"

}

locals {
  httpd_conf_file = ["app1.conf"]
}

#upload files to container
resource "azurerm_storage_blob" "httpd_files_container_blob" {
  for_each               = toset(local.httpd_conf_file)
  name                   = each.value
  storage_account_name   = azurerm_storage_account.storage_account.name
  storage_container_name = azurerm_storage_container.httpd_file_container.name
  type                   = "Block"
  source                 = "app-scriptis/${each.value}"
}