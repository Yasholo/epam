variable "key_name" {
    description = "yashepam"
}

variable "USER_NAME" {
    description = "yashepam"
}

variable "key_path" {
    description = "/home/Cactus/Downloads/yashepam"
    default = ""
}
variable "subnet_id" {
    description = "subnet-05ac2b48893779d32"
    default = ""
}
variable "vpc_id" {
    description = "vpc-02b4a369d3fe6666e"
    default = ""
}

variable "AWS_ACCESS_KEY_ID" {}
variable "AWS_SECRET_ACCESS_KEY" {}
variable "SERVER_SIZE" {}
variable "NUM_SERVERS" {}
variable "APP_NAME" {}
variable "ENV_NAME" {}

variable "aws_region" {
    description = "AWS region to launch Compute."
    default = "ap-south-1"
}

variable "aws_amis" {
    description = "ami-02eb7a4783e7e9317"
    default = "ami-f8768a80" 
	}
