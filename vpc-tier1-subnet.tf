# Create Web subnet
resource "aws_subnet" "tier1-sub" {
  vpc_id                  = "${aws_vpc.default.id}"
  availability_zone       = "us-east-1b"
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name          = "tier1-sub"
    Resource      = "Subnet"
    ResourceGroup = "asotelo-tf-rgp"
    Ecosystem     = ""
    Application   = ""
    Environment   = ""
  }
}
