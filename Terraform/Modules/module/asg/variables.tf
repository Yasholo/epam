variable "environment_name" {
  description = "Enter env in which module is running, it will attached with names keyword of most resources"
  default     = "faulty_name"
}

#CONFIGURATION FOR LAUCNH_TEPLATE
variable "instance_type" {
  description = "Instance type default it set to low, to cut charges. Use bigger in production"
  default = "t2.micro" 
}

variable "key_name" {
  description = "SSH-KEY which can connect to this Virtual Machine"
  default = "po's-key" 
}

variable "vpc_security_group_ids" {
  description = "vpc_security_group_id will be entered by main.tf file in root"
}
# Configuration details for ASG
variable "min_size_of_asg" {
  default = 1
}

variable "desired_size_of_asg" {
  default = 1
}

variable "max_size_of_asg" {
  default = 2
}