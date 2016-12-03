output "webservers_ip" {
  value = ["${aws_instance.web.*.private_ip}"]
}

