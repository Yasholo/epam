#### Configuration code for Terraform
```yaml

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "ap-south-1"
}


resource "aws_vpc" "vpc" {
  cidr_block = "192.168.1.0/24"

  tags = {
    Name = "terraform_vpc"
  }
}

resource "aws_subnet" "subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-south-1a"
  cidr_block        = "192.168.1.0/27"

  tags = {
    Name = "terraform_subnet_1"
  }

}

resource "aws_subnet" "subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  availability_zone = "ap-south-1b"
  cidr_block        = "192.168.1.32/27"

  tags = {
    Name = "terraform_subnet_2"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "igw"
  }
}


resource "aws_route_table" "vpc_rt_public" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "rt-for-internet-access"
  }
}


resource "aws_route_table_association" "route_table_association_subnet_1" {
  subnet_id      = aws_subnet.subnet-1.id
  route_table_id = aws_route_table.vpc_rt_public.id
}

resource "aws_route_table_association" "route_table_association_subnet_2" {
  subnet_id      = aws_subnet.subnet-2.id
  route_table_id = aws_route_table.vpc_rt_public.id
}

#// Security Groups
resource "aws_security_group" "allow_ssh_for_vm" {
  name        = "allow_ssh_sg"
  description = "Allow SSH inbound connections"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "_allow_ssh_sg"
  }
}


resource "aws_instance" "terraform_instance" {
  ami           = "ami-02eb7a4783e7e9317"
  instance_type = "t2.micro"
  key_name      = "po's-key"
  subnet_id     = aws_subnet.subnet-1.id
  vpc_security_group_ids = [aws_security_group.allow_ssh_for_vm.id]

  tags = {
    Name = "terraform_instance"
  }
}

resource "aws_lb" "lb" {
  name               = "terraform-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_ssh_for_vm.id]
  subnets            = [aws_subnet.subnet-1.id, aws_subnet.subnet-2.id]

  tags = {
    Name = "terraform-lb"
  }
}

resource "aws_lb_target_group" "alb-tg" {
  name     = "tf-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

#// OUTPUT VARIABLE DATA

output "aws_vpc_id_0" {
  value = aws_vpc.vpc.id
}

output "aws_instance_o" {
  value = aws_instance.terraform_instance.id
}

```
