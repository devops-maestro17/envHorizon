resource "aws_instance" "server-1" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.instance_sg
  subnet_id = var.subnet_id_1
}

resource "aws_instance" "server-2" {
  ami = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = var.instance_sg
  subnet_id = var.subnet_id_2
}