variable "environment_name" {
  description = "Enter env in which module is running, it will attached with names keyword of most resources"
  default     = "faulty_name"
}

variable "vpc_security_group_idsx" {
  description = "vpc_security_group_id will be entered by main.tf file in root itself."
}
# Configuration details for ASG
variable "public_subnet_idsx" {
  description = "this subnet id will be given by root main.tf"
}
