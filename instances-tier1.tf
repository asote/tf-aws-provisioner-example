resource "aws_instance" "web" {
  count                  = "1"
  ami                    = "ami-83d2f894"                   # Microsoft Windows Server 2012 R2 Base - ami-83d2f894
  instance_type          = "t2.micro"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]

  subnet_id         = "${aws_subnet.tier1-sub.id}"
  source_dest_check = false
  key_name          = "${var.aws_key_name}"

  # Enable WinRM
  connection {
    type     = "winrm"
    user     = "Administrator"
    password = "${var.admin_password}" # This is also the password to log in.
  }

  user_data = <<EOF
<script>
  winrm quickconfig -q & winrm set winrm/config/winrs @{MaxMemoryPerShellMB="300"} & winrm set winrm/config @{MaxTimeoutms="1800000"} & winrm set winrm/config/service @{AllowUnencrypted="true"} & winrm set winrm/config/service/auth @{Basic="true"}
</script>
<powershell>
  netsh advfirewall firewall add rule name="WinRM in" protocol=TCP dir=in profile=any localport=5985 remoteip=any localip=any action=allow
  $admin = [adsi]("WinNT://./administrator, user")
  $admin.psbase.invoke("SetPassword", "${var.admin_password}")
</powershell>
EOF

  tags = {
    Name          = "web-vm${count.index + 1}"
    Resource      = "Instance"
    ResourceGroup = "asotelo-tf-rgp"
    Ecosystem     = ""
    Application   = ""
    Environment   = ""
  }
}
