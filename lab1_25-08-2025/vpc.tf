resource "aws_vpc" "team_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = { Name = "${var.team_name}-vpc" }
}

resource "aws_subnet" "team_subnet" {
  vpc_id                  = aws_vpc.team_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = { Name = "${var.team_name}-subnet" }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.team_vpc.id
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.team_vpc.id
}

resource "aws_route" "default" {
  route_table_id         = aws_route_table.rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.team_subnet.id
  route_table_id = aws_route_table.rt.id
}