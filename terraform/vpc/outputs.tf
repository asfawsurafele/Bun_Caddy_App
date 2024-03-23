output "vpc" {
  value = aws_vpc.vpc_1
}

output "sn_1" {
  value = aws_subnet.subnet_1

}

output "sn_2" {
  value = aws_subnet.subnet_2

}

output "gw_1" {
  value = aws_internet_gateway.gw_1
}

output "rt_1" {
  value = aws_route_table.rt_1
}
