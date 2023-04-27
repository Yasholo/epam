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

# Using Count Expression this create list of resource
resource "aws_iam_user" "example" {
  count = 3
  name  = "pranay_iam_role_${count.index}"
}

# Using FOR_EACH Expression, this create MAP
resource "aws_iam_user" "example_for_each" {
  for_each = toset(var.iam_user_names)
  name     = each.value
}