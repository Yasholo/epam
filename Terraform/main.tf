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
  region = var.region_name
}

variable "region_name" {
  type        = string
  description = "The region to deploy the resources"
  default     = "ap-south-1"
}

variable "bucket_prefix" {
  type        = string
  description = "Enter Bucket name here, aws add will extra hash to it"
  default     = "class-task-bucket-"

}


# CREATING A BUCKET
resource "aws_s3_bucket" "bucket" {
  # bucket = var.bucket_prefix

  # use this if you want to add a hash to the bucket name. 
  bucket_prefix = var.bucket_prefix

  # acl    = "private"

  tags = {
    Name = "TerraformCreatedThisBucket"
  }
}


output "bucket_id" {
  value = resource.aws_s3_bucket.bucket.id
}
