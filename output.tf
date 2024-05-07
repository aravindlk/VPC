output "instance-name-1" {
  value = aws_instance.private_instance
}

output "instance-name-2" {
  value = aws_instance.public_instance
}

output "public-ip-address" {
    value = aws_instance.public_instance
}

output "private-ip-address-2" {
  value = aws_instance.public_instance
}

output "private-ip-address-1" {
  value = aws_instance.private_instance
}

output "vpc-name" {
  value = aws_vpc.my_vpc
}

output "vpc-id" {
  value = aws_vpc.my_vpc
}

output "rt-name-public" {
  value = aws_route_table.public_rt
}

output "rt-name-private" {
  value = aws_route_table.private_rt
}

output "rt-id-public" {
  value = aws_route_table.public_rt
}

output "rt-id-private" {
  value = aws_route_table.private_rt
}

output "subnet-name-public" {
  value = aws_subnet.public_subnet
}

output "subnet-name-private" {
  value = aws_subnet.private_subnet
}

output "igw-name" {
  value = aws_internet_gateway.my_igw
}

output "igw-id" {
  value = aws_internet_gateway.my_igw
}

output "ep-id" {
  value = aws_eip.nat_gateway
}

output "nat-id" {
  value = aws_nat_gateway.nat_gateway
}