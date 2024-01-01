resource "aws_lb" "load_balancer" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.lb_security_group]
  subnets            = [var.lb_subnets[0], var.lb_subnets[1]]
  tags = {
    Name = "App LB-${var.environment_name}"
  }
}

resource "aws_lb_target_group" "lb_target_group" {
  name     = "App-LB-TG"
  port     = 8080
  protocol = "HTTP"
  vpc_id   = var.lb_vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_lb_target_group_attachment" "lb_attach" {
  target_group_arn = aws_lb_target_group.lb_target_group.arn
  count            = length(var.lb_target_id)
  target_id        = element(var.lb_target_id, count.index)
  port             = 8080
}

resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.lb_target_group.arn
    type             = "forward"
  }
}