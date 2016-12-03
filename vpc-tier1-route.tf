# Create route table for web subnet
resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.default.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.default.id}"
  }

  tags {
    Name          = "Route Table"
    Resource      = "RT"
    ResourceGroup = "asotelo-tf-rgp"
    Ecosystem     = ""
    Application   = ""
    Environment   = ""
  }
}

# Associate route table with web subnet
resource "aws_route_table_association" "public" {
  subnet_id      = "${aws_subnet.tier1-sub.id}"
  route_table_id = "${aws_route_table.public.id}"
}
