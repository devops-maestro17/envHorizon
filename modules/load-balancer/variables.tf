variable "lb_security_group" {
  type        = string
  description = "Load Balancer Security Group"
}

variable "lb_subnets" {
  type        = list(string)
  description = "Subnet IDs in which the Load Balancer will reside"
}

variable "lb_vpc_id" {
  type        = string
  description = "VPC ID in which the Load Balancer will reside"
}

variable "lb_target_id" {
  type        = list(string)
  description = "Load Balancer Target ID"
}

variable "environment_name" {
  type = string
}