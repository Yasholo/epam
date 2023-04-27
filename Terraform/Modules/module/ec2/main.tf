resource "aws_instance" "vm1" {
  ami = "ami-0f8ca728008ff5af4"

  #This is assigning public IP. For now reason unknown
  associate_public_ip_address = true

  subnet_id = var.subnet_id
  availability_zone = "ap-south-1b"
  instance_type = "t2.micro"
  vpc_security_group_ids = [var.vpc_sg_groups]
#   key_name = "Your_SSH_Key"
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update && apt upgrade -y
              sudo apt-get install -y nginx
              EOF

    tags =  {
        Name = "Web-Server_Instance"
    }
}