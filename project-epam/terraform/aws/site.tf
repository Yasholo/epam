provider "aws" {
  access_key = var.AWS_ACCESS_KEY_ID
  secret_key = var.AWS_SECRET_ACCESS_KEY
  region     = var.aws_region
}

# Port whitelisting 
resource "aws_security_group" "default" {
  name        = "FinalProject-${var.APP_NAME}-${var.USER_NAME}"
  description = "app ingress/egress"
  tags = {
    Name = "FinalProject-${var.APP_NAME}-${var.USER_NAME}"
  }
  vpc_id = var.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9090
    to_port     = 9090
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9093
    to_port     = 9093
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  instance_type               = "t2.micro"
  count                       = var.NUM_SERVERS
  ami                         = var.aws_amis
  key_name                    = "yashepam-01"
  vpc_security_group_ids      = [aws_security_group.default.id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = true
  tags = {
    Name = "FinalProject-${var.APP_NAME}-${var.USER_NAME}"
  }
}

# Using terraform module to run ansible playbooks
module "ansible_provisioner" {
  source  = "github.com/cloudposse/tf_ansible"  # Specify the module version
  arguments = ["--user=Yashkumar-11910683 --private-key=/home/Cactus/Downloads/yashepam-01.pem"]
  envs     = ["host=${aws_instance.web[0].public_ip}"]
  playbook = "../../ansible/playbook/deployment.yml"
  dry_run  = false
}

