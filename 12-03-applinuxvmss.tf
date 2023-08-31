
# Locals Block for custom data
locals {
appvm_custom_data = <<CUSTOM_DATA
#!/bin/sh
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo chmod -R 777 /var/www/html 
sudo mkdir /var/www/html/appvm
sudo echo "Welcome to stacksimplify - AppVM App1 - VM Hostname: $(hostname)" > /var/www/html/index.html
sudo echo "Welcome to stacksimplify - AppVM App1 - VM Hostname: $(hostname)" > /var/www/html/appvm/hostname.html
sudo echo "Welcome to stacksimplify - AppVM App1 - App Status Page" > /var/www/html/appvm/status.html
sudo echo '<!DOCTYPE html> <html> <body style="background-color:rgb(255, 99, 71);"> <h1>Welcome to Stack Simplify - AppVM APP-1 </h1> <p>Terraform Demo</p> <p>Application Version: V1</p> </body></html>' | sudo tee /var/www/html/appvm/index.html
sudo curl -H "Metadata:true" --noproxy "*" "http://169.254.169.254/metadata/instance?api-version=2020-09-01" -o /var/www/html/appvm/metadata.html
CUSTOM_DATA 
}




#resource for VM

resource "azurerm_linux_virtual_machine_scale_set" "app-linuxvmss" {
  name                = "${local.resource_group_name_perfix}-app-linuxvmss"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku                 = "Standard_DS1_v2"
  instances           = "3"
  admin_username      = "azureuser"
  admin_ssh_key {
    username   = "azureuser"
    public_key = file("${path.module}/ssh-keys/terraform-azure.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "8_5-gen2"
    version   = "latest"

  }
  upgrade_mode = "Automatic"
  network_interface {
    name                      = "app-linuxvmss"
    primary                   = "true"
    network_security_group_id = azurerm_network_security_group.app_vmss_nsg.id
    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = azurerm_subnet.app-subnet.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.app_lb_backend_address_pool.id]
    }
  }

  custom_data = base64encode(local.appvm_custom_data)

}