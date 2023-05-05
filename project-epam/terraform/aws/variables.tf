variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
    default="yashepam-01"
}

variable "USER_NAME" {
    description = "Username to be used in the names of created resources."
    default = "Yashkumar-11910683"
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
    default = "/home/Cactus/Downloads/yashepam-01"
}
variable "subnet_id" {
    description = "Which subnet id to create this in?"
    default = "subnet-05ac2b48893779d32"
}
variable "vpc_id" {
    description = "Which vpc id to create this in?"
    default = "vpc-02b4a369d3fe6666e"
}

variable "AWS_ACCESS_KEY_ID" {
    default = "AKIAXPPCKD62WTALZOUF"
}
variable "AWS_SECRET_ACCESS_KEY" {
    default = "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"
}
variable "SERVER_SIZE" {
    default = "t2.micro"
}
variable "NUM_SERVERS" {}
variable "APP_NAME" {
    default = "Dashboard-monitoring"
}
variable "ENV_NAME" {
    default = "Epam-project"
}

variable "aws_region" {
    description = "Mumbai region"
    default = "ap-south-1"
}

variable "aws_amis" {
    description = "Ubuntu image"
    default = "ami-02eb7a4783e7e9317"
}
