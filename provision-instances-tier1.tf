# Install IIS
resource "null_resource" "copy_scripts" {
  provisioner "file" {
    source      = "conf/Install-IIS.ps1"
    destination = "C:/Install-IIS.ps1"
  }

  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.admin_password}"          # This is also the password to log in.
    host     = "${aws_instance.web.public_dns}"
    timeout  = "10m"
  }

  depends_on = ["aws_instance.web"]
}

resource "null_resource" "install" {
  provisioner "remote-exec" {
    inline = [
      "powershell.exe -sta -ExecutionPolicy Unrestricted -file C:\\Install--IIS.ps1",
    ]
  }

  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.admin_password}"          # This is also the password to log in.
    host     = "${aws_instance.web.public_dns}"
    timeout  = "10m"
  }

  depends_on = ["null_resource.copy_scripts"]
}
