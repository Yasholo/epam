


resource "aws_launch_template" "ubuntu" {
  # Basic Details
  # name_prefix = "terraform-ubuntu"
  name = "Ubuntu_template_${var.environment_name}"

  # Instance Details
  instance_type = var.instance_type
  key_name      = var.key_name
  # user_data = filebase64("${path.module}/example.sh")


  # Network Details
  vpc_security_group_ids = [var.vpc_security_group_idsx]

  # Storage Details
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 8
      volume_type = "gp2"
    }
  }
  # image_id = data.aws_ami.ubuntu.id         # Ubuntu 20.04
  image_id = "ami-02eb7a4783e7e9317" # Ubuntu 22.04
  # image_id = "ami-0b2b8d1c5f8f1b8a5"          # Ubuntu 18.04

  # Advance & Other
  credit_specification {
    cpu_credits = "unlimited"
  }

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name        = "terraform-ubuntu-template"
      Managed_By  = "Terraform"
      Environment = "${var.environment_name}"
    }
  }


  # Required when using a launch configuration with an auto scaling group. 
  #Just enable this for now, otherwise it take more time to delte resources
  lifecycle {
    create_before_destroy = true
  }

}

# #// Launching Auto Scaling Group
resource "aws_autoscaling_group" "asg" {
  name = "${var.environment_name}-asg"

  availability_zones = ["ap-south-1a"]
  min_size           = var.min_size_of_asg
  desired_capacity   = var.desired_size_of_asg
  max_size           = var.max_size_of_asg

  launch_template {
    id      = aws_launch_template.ubuntu.id
    version = "$Latest"
  }

  #Some Advance configuration
  # health_check_grace_period = 300
  # health_check_type         = "ELB"
  # force_delete              = true
  # termination_policies      = ["OldestInstance"]
}