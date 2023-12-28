variable "cidr_block" {
  type = string
}

variable "subnet_1_cidr" {
  type = string
}

variable "subnet_1_az" {
  type = string
}

variable "subnet_2_cidr" {
  type = string
}

variable "subnet_2_az" {
  type = string
}

variable "route_table_cidr" {
  type = string
}

variable "from_port" {
  type = number
}

variable "to_port" {
  type = number
}

variable "sg_cidr" {
  type = list(string)
}