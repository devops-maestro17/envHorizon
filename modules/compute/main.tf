resource "aws_instance" "web-server-1" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id[0]
  vpc_security_group_ids = [var.security_group]

  tags = {
    Name = "Web-Server-1-${var.environment_name}"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from Server 1" > index.html
              python3 -m http.server 8080 &
              EOF
}

resource "aws_instance" "web-server-2" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id[1]
  vpc_security_group_ids = [var.security_group]

  tags = {
    Name = "Web-Server-2-${var.environment_name}"
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World from Server 2" > index.html
              python3 -m http.server 8080 &
              EOF
}