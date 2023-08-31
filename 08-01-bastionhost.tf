
# local block custom data
locals {
  bastion_host_custom_data = <<CUSTOM_DATA
#!/bin/sh
#sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd  
sudo systemctl stop firewalld
sudo systemctl disable firewalld
sudo yum install -y telnet
sudo chmod -R 777 /var/www/html 
sudo echo "Welcome to stacksimplify - Bastion Host - VM Hostname: $(hostname)" > /var/www/html/index.html
CUSTOM_DATA  
}




#create bastion resource

resource "azurerm_public_ip" "bastion_host_pip" {
  name                = "${local.resource_group_name_perfix}-bastion-host-pip"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

#Create nic

resource "azurerm_network_interface" "bastion_host_linuxvm_nic" {
  name                = "${local.resource_group_name_perfix}-bastion-linuxvm-nic"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "bastion-host-ip-1"
    subnet_id                     = azurerm_subnet.bastion-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion_host_pip.id

  }

}

#Create Bastion host vm

resource "azurerm_linux_virtual_machine" "bastion-host-linuxvm" {
  name                  = "${local.resource_group_name_perfix}-bastion-linuxvm"
  location              = azurerm_resource_group.rg.location
  resource_group_name   = azurerm_resource_group.rg.name
  size                  = "Standard_DS1_V2"
  admin_username        = "azureuser"
  network_interface_ids = [azurerm_network_interface.bastion_host_linuxvm_nic.id]
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
  custom_data = base64encode(local.bastion_host_custom_data)
}

