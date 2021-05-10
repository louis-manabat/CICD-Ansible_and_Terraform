resource "aws_key_pair" "deployer" {
  key_name   = "s3719633-assignment-2-key"
  public_key = file("~/keys/ec2-key.pub")
}

resource "aws_lb" "todo_app_lb" {
  name               = "todo-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http_ssh.id]
  subnets            = [aws_subnet.public_az1.id, aws_subnet.public_az2.id, aws_subnet.public_az3.id]

  tags = {
    Environment = "production"
  }
}

resource "aws_lb_target_group" "todo_app_lb_tg" {
  name     = "todo-app-lb-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc.id
}

resource "aws_lb_listener" "todo_app_lb_listener" {
  load_balancer_arn = aws_lb.todo_app_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.todo_app_lb_tg.arn
  }
}

resource "aws_instance" "todo_app_ec2" {
  ami             = "ami-0d5eff06f840b45e9"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.allow_http_ssh.id]
  key_name        = aws_key_pair.deployer.key_name
  subnet_id       = aws_subnet.private_az1.id
}