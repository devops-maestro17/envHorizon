variable "vpc_cidr_block" {
  type        = string
  description = "VPC CIDR Block"
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "Public Subnets CIDR Range"
}

variable "private_subnet_cidrs" {
  type        = list(string)
  description = "Private Subnets CIDR Range"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "ingress_from_port" {
  type        = map(any)
  description = "Ingress From Ports"
}

variable "ingress_protocol" {
  type = string
}

variable "ingress_cidr_block" {
  type        = list(string)
  description = "Ingress CIDR Block"
}

variable "environment_name" {
  type = string
}