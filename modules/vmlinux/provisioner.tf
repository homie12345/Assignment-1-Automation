resource "null_resource" "linux_provisioner" {
  for_each = var.linux_name
  depends_on = [
    azurerm_linux_virtual_machine.linux_vm
  ]

  provisioner "remote-exec" {
    inline = [
      "hostname"
    ]

    connection {
      type        = "ssh"
      host        = azurerm_linux_virtual_machine.linux_vm[each.key].public_ip_address
      user        = var.vm_admin_user
      private_key = file(var.linux_admin_ssh_key.private_key)
    }
  }
}