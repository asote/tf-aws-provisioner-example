output "webservers_ip" {
  value = ["${aws_instance.web.*.private_ip}"]
}

output "LBext_DNS" {
  value = "${aws_elb.web.dns_name}"
}

output "LBext_Security_Group" {
  value = "${aws_elb.web.source_security_group}"
}
