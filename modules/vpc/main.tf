resource "aws_vpc" "vpc" {
  cidr_block           = var.cidr_vpc_block
  instance_tenancy     = "default"
  enable_dns_hostnames = true
  tags = {
    "kubernetes.io/cluster/EksCluster" = "shared"
  }
}
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.public)
  cidr_block        = element(var.public, count.index)
  availability_zone = element(var.availability_zone, count.index)

  map_public_ip_on_launch = true
  tags = {
    "kubernetes.io/cluster/EksCluster" = "shared"
    "kubernetes.io/role/elb"           = 1
  }
}
resource "aws_subnet" "private" {
  vpc_id            = aws_vpc.vpc.id
  count             = length(var.private)
  cidr_block        = element(var.private, count.index)
  availability_zone = element(var.availability_zone, count.index)
  tags = {
    "kubernetes.io/cluster/EksCluster" = "shared"
    "kubernetes.io/role/internal-elb"  = 1
  }

}
resource "aws_internet_gateway" "public_igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "my_igw"
  }
}
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public_igw.id
  }

  tags = {
    Name = "my_route"
  }
}
resource "aws_route_table_association" "association" {
  count          = length(var.public)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public_route.id
}

resource "aws_eip" "nat_gw" {
  vpc = true
}
resource "aws_nat_gateway" "priv_ngw" {
  allocation_id = aws_eip.nat_gw.id
  subnet_id     = aws_subnet.public[0].id
  depends_on    = [aws_eip.nat_gw]
  tags = {
    Name = "private_ngw"
  }
}
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.priv_ngw.id
  }
  tags = {
    Name = "private_route"
  }
}
resource "aws_route_table_association" "pri_association" {
  count          = length(var.private)
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = aws_route_table.private_route.id
}