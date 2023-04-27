

resource "aws_lb" "lb" {
  name               = "${var.environment_name}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.vpc_security_group_idsx]
  subnets            = var.public_subnet_idsx

  tags = {
    Name = "terraform-lb"
  }
}