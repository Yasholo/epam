#Variable Area
# variable "channel-name" {
#   default = "cartoon_channels"
#   description = "Enter name of channel"
# }

variable "iam_user_names" {
  description = "Create IAM users with these names"
  type        = list(string)
  default     = ["jetix", "nick", "cartoon-network", "pogo"]

}