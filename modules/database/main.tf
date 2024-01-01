resource "aws_db_subnet_group" "db_subnet" {
  name = "rds-subnet-group"
  subnet_ids = var.db_subnet_group
}

resource "aws_db_instance" "db_instance" {
  allocated_storage    = var.storage
  storage_type         = var.storage_type
  engine               = var.engine
  engine_version       = var.engine_version
  instance_class       = var.instance_class
  db_name              = var.db_name
  username             = var.db_user
  password             = var.db_pass
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet.name

  tags = {
    Name = "DB-Instance-${var.environment_name}"
  }
}

