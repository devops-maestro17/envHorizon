variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_sg" {
  type = list(string)
}

variable "subnet_id_1" {
  type = string
}

variable "subnet_id_2" {
  type = string
}