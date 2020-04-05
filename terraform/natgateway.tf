resource "aws_eip" "nat" {
  count = var.nat_gateway_count

  vpc = true

  tags = merge({
    Name = "natgateway-${count.index}"
  }, local.common_tags)
}

resource "aws_nat_gateway" "nat" {
  count = var.nat_gateway_count

  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge({
    Name = "${var.project_name}-nat-${count.index}"
  }, local.common_tags)
}
