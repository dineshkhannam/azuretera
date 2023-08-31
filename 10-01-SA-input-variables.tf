variable "storage_account_name" {
  description = "storage account name"
  type        = string
}

variable "storage_account_tier" {
  description = "storage account tier"
  type        = string
}

variable "storage_account_replication_type" {
  description = "Storage Account replication Type"
  type        = string

}

variable "storage_account_kind" {
  description = "storage account kind"
}

variable "storage_website_index_document" {
  description = "static website index document"
  type        = string
}

variable "storage_website_error_document" {
  description = "static website error document"
  type        = string

}