resource "aws_vpc" "my_vpc" {
  cidr_block       = "192.168.50.0/24"
  enable_dns_hostnames = true
  tags = {
    Name = "ClassTask VPC"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "192.168.50.0/27"
  availability_zone = "ap-south-1a"
  tags = {
    Name = "Public Subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "192.168.50.32/27"
  availability_zone = "ap-south-1b"
  tags = {
    Name = "private Subnet"
  }
}

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "My VPC - Internet Gateway"
  }
}

resource "aws_route_table" "rt_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_vpc_igw.id
    }
    tags = {
        Name = "Public_Subnet_rt"
    }
}

resource "aws_route_table_association" "rt_public_subnet" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.rt_public_subnet.id
}

resource "aws_route_table" "rt_private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    #We dont need whole route block, when creating rt for private subnet.
    # route {
        # cidr_block = "192.168.50.32/27"
        #rt is for private subnet. Hence no gateway for this rt
        # gateway_id = aws_internet_gateway.my_vpc_igw.id
    # }
    tags = {
        Name = "Private_Subnet_rt"
    }
}

resource "aws_route_table_association" "rt_private_subnet" {
    subnet_id = aws_subnet.private.id
    route_table_id = aws_route_table.rt_private_subnet.id
}

resource "aws_security_group" "vm1-sg" {
  name = "webserver-sg"
  vpc_id = aws_vpc.my_vpc.id
  #SSH
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  #HTTP PORT_WEBSERVER
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "All"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "sg-for-webserver"
  }
}
