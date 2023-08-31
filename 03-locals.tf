locals {
  owners                     = var.BA_DIV
  envirnoment                = var.environment
  resource_group_name_perfix = "${var.BA_DIV}-${var.environment}"
  common_tags = {
    owners      = local.owners
    envirnoment = local.envirnoment
  }
}