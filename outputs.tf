output "instance_IP" {
  value = ["${aws_instance.web.public_ip}"]
}
