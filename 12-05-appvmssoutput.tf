output "app_vmss_id" {
  description = "App vm scale sets id"
  value       = azurerm_linux_virtual_machine_scale_set.app-linuxvmss.id

}