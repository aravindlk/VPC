resource "aws_vpc" "my_vpc" {
  cidr_block           = var.vpc-cidr1
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name       = "MyVPC"
    Environment = "Production"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id    
  cidr_block = var.vpc-cidr2
  availability_zone = var.pubsub-availability-zone
  map_public_ip_on_launch = true
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = var.vpc-cidr3
  availability_zone = var.prisub-availability-zone
}

resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "public_sg" {
  vpc_id = aws_vpc.my_vpc.id
  # Define rules for inbound/outbound traffic
}

resource "aws_security_group" "private_sg" {
  vpc_id = aws_vpc.my_vpc.id
  # Define rules for inbound/outbound traffic
}


# Define your VPC, subnets, and security groups here (not shown for brevity)

# Create a public EC2 instance
resource "aws_instance" "public_instance" {
  ami           = var.ami1  # Replace with your desired AMI ID
  instance_type = var.public-instance-type
  subnet_id     = aws_subnet.public_subnet.id
  key_name      = "aws-login"   # Replace with your key pair name
  security_groups = [aws_security_group.public_sg.id]

  tags = {
    Name = "PublicInstance"
  }
}

# Create a private EC2 instance
resource "aws_instance" "private_instance" {
  ami           = var.ami2  # Replace with your desired AMI ID
  instance_type = var.private-instance-type
  subnet_id     = aws_subnet.private_subnet.id
  key_name      = "aws-login"   # Replace with your key pair name
  security_groups = [aws_security_group.private_sg.id]

  tags = {
    Name = "PrivateInstance"
  }
}

resource "aws_eip" "nat_gateway" {
  vpc = true
}

resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.private_subnet.id  # Use your private subnet ID
  tags = {
    Name = "MyNATGateway"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  # Other route table settings...
}

resource "aws_route_table_association" "private_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}



