variable "BA_DIV" {
  description = "busniess division"
  type        = string
  default     = "SAP"
}

variable "environment" {
  description = "envirnoment for stages"
  type        = string
  default     = "dev"
}

variable "resource_group_name" {
  description = "resource group name"
  type        = string
  default     = "rg-default"

}

variable "resource_group_location" {
  description = "resource group location"
  type        = string
  default     = "eastus"

}