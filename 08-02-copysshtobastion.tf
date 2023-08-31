#create null resources

resource "null_resource" "null_copy_2_bastion" {
  depends_on = [azurerm_linux_virtual_machine.bastion-host-linuxvm]
  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.bastion-host-linuxvm.public_ip_address
    user        = azurerm_linux_virtual_machine.bastion-host-linuxvm.admin_username
    private_key = file("${path.module}/ssh-keys/terraform-azure.pem")

  }

  provisioner "file" {
    source      = "ssh-keys/terraform-azure.pem"
    destination = "/tmp/terraform-azure.pem"
  }

  #Remote exec provisioner
  provisioner "remote-exec" {
    inline = ["sudo chmod 400 /tmp/terraform-azure.pem"]

  }

}