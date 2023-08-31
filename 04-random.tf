#random resource block
resource "random_string" "random" {
  length  = 8
  upper   = false
  number  = false
  special = false

}