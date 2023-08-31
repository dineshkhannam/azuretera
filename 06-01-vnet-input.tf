#virutal network 

variable "vnet_name" {
  description = "virutal network name"
  type        = string
  default     = "vnet-default"
}

variable "vnet_address" {
  description = "virutal network address"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# web subnet

variable "web_subnet_name" {
  description = "web subnet name"
  type        = string
  default     = "web-subnet"
}

variable "web_subnet_address" {
  description = "web subnet address"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "app_subnet_name" {
  description = "app subnet address"
  type        = string
  default     = "app-subnet"
}

variable "app_subnet_address" {
  description = "app subnet address"
  type        = list(string)
  default     = ["10.0.11.0/24"]
}

variable "db_subnet_name" {
  description = "db tier subnet name"
  type        = string
  default     = "db-subnet"
}

variable "db_subnet_address" {
  description = "db tier subnet address"
  type        = list(string)
  default     = ["10.0.21.0/24"]
}

variable "bastion_subnet" {
  description = "bastion host subnet"
  type        = string
  default     = "bastion-subnet"
}

variable "bastion_subnet_address" {
  description = "bastion host address"
  type        = list(string)
  default     = ["10.0.100.0/24"]

}

variable "bastion_service_subnet_name" {
  description = "bastion service snet"
  type        = string
  default     = "AzureBastionSubnet"

}

variable "bastion_service_address_prefixes" {
  description = "bastion service address"
  type        = list(string)
  default     = ["10.0.101.0/27"]

}