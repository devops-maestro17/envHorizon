variable "ami" {
  type        = string
  description = "AMI ID of EC2 Instance"
}

variable "instance_type" {
  type        = string
  description = "EC2 Instance Type"
}

variable "subnet_id" {
  type        = list(string)
  description = "Subnet IDs for EC2 Instance"
}

variable "security_group" {
  type        = string
  description = "Security Group for EC2 Instance"
}

variable "environment_name" {
  type = string
}