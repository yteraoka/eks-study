#-----------------------------------------------------------------------------
# Public Subnet
#-----------------------------------------------------------------------------
resource "aws_subnet" "public" {
  count = length(var.public_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  availability_zone = var.public_subnet_cidrs[count.index].az
  cidr_block        = var.public_subnet_cidrs[count.index].cidr

  map_public_ip_on_launch = true

  tags = merge({
    Name                     = "${var.project_name}-public-${count.index}"
    "kubernetes.io/role/elb" = 1
  }, local.common_tags)
}

resource "aws_default_route_table" "default_route_table" {
  default_route_table_id = aws_vpc.main.default_route_table_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = merge({
    Name = "${var.project_name}-default-route-table"
  }, local.common_tags)
}


#-----------------------------------------------------------------------------
# Private Subnet
#-----------------------------------------------------------------------------
resource "aws_subnet" "private" {
  count = length(var.private_subnet_cidrs)

  vpc_id            = aws_vpc.main.id
  availability_zone = var.private_subnet_cidrs[count.index].az
  cidr_block        = var.private_subnet_cidrs[count.index].cidr

  tags = merge({
    Name                              = "${var.project_name}-private-${count.index}"
    "kubernetes.io/role/internal-elb" = 1
  }, local.common_tags)
}

resource "aws_route_table" "private_route_table" {
  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat[0].id
    # nat_gateway_id = aws_nat_gateway.nat[count.index].id
  }

  tags = merge({
    Name = "${var.project_name}-private-route-table-${count.index}"
  }, local.common_tags)
}

resource "aws_route_table_association" "private_route" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private_route_table[count.index].id
}
