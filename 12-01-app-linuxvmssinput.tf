# Input variable for App linux vmss
variable "app_vmss_nsg_inbound_ports" {
  description = "app vmss nsg inbound ports"
  type        = list(string)
  default     = [80, 22, 443]

}