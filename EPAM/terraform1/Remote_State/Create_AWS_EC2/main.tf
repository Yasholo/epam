#main.tf
provider "aws" {
   region = "ap-south-1"
 }
 
 terraform {
   backend "s3" {
     bucket = "terraform-s3-backend-with-locking69"
     key = "terraform/backend/terraform_aws.tfstate"
     region = "ap-south-1"
     dynamodb_table = "terraform-s3-backend-locking"
     encrypt = true
   }
 }
 
 resource "aws_instance" "terraform_aws_ec2" {
   ami = "ami-07d3a50bd29811cd1"
   instance_type = "t2.micro"
 }
