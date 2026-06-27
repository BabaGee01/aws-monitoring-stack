variable "instance_id" {
  description = "EC2 instance ID from the EC2 module"
  type        = string
}

variable "alert_email" {
  description = "Email address for SNS alarm notifications"
  type        = string
}