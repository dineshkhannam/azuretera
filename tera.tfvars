BA_DIV                  = "SAP"
environment             = "dev"
resource_group_name     = "RG"
resource_group_location = "east us"
vnet_name               = "vnet"

bastion_service_subnet_name      = "AzureBastionSubnet"
bastion_service_address_prefixes = ["10.0.101.0/27"]

web_linuxvm_instance_count = 3

storage_account_kind = "StorageV2"
storage_account_name = "staticwebsite"
storage_account_replication_type = "LRS"
storage_account_tier = "Standard"
storage_website_index_document = "index.html"
storage_website_error_document = "error.html"