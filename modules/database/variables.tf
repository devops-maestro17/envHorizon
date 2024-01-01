variable "storage" {
  type        = number
  description = "DB Storage"
}

variable "storage_type" {
  type        = string
  description = "DB Storage Type"
}

variable "engine" {
  type        = string
  description = "DB Engine"
}

variable "engine_version" {
  type        = string
  description = "DB Engine Version"
}

variable "instance_class" {
  type        = string
  description = "DB Instance Class"
}

variable "db_name" {
  type        = string
  description = "DB Name"
}

variable "db_user" {
  type        = string
  description = "DB Username"
}

variable "db_pass" {
  type        = string
  description = "DB Password"
}

variable "db_subnet_group" {
  type        = list(string)
  description = "DB Subnet Group"
}

variable "environment_name" {
  type = string
}