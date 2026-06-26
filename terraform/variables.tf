variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "eu-west-2"
}

variable "ami_id" {
  description = "Amazon Linux 2023 AMI ID for eu-west-2"
  type        = string
}

variable "key_name" {
  description = "Name of your EC2 key pair"
  type        = string
}

variable "my_ip" {
  description = "Your public IP in CIDR format e.g. 82.123.45.67/32"
  type        = string
}

variable "alert_email" {
  description = "Email address for CloudWatch alarm notifications"
  type        = string
}