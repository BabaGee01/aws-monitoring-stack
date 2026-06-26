variable "vpc_id" {
  description = "VPC ID from the VPC module"
  type        = string
}

variable "subnet_id" {
  description = "Public subnet ID from the VPC module"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance (Amazon Linux 2023)"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair for SSH access"
  type        = string
}

variable "my_ip" {
  description = "Your public IP in CIDR format e.g. 82.123.45.67/32"
  type        = string
}