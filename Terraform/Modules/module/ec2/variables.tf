variable "vpc_sg_groups" {
  description = "This value contain list of SG Groups. Which will be send by root main module. And those values will be retrived by vpc_module"
#   type = list
}

variable "subnet_id" {
  description = "Give subnet ID here, it will automatically launched in the desired VPC"
}