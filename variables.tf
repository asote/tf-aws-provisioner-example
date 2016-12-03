variable "aws_key_name" {
  description = "IAM public access key name. "
}

variable "count" {
  description = "Number of instances"
  default     = "1"
}

variable "admin_password" {
  default = "$hIs*spNC10Ye"
  description = "Windows Administrator password to login as."
}
