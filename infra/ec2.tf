resource "aws_key_pair" "deployer" {
  key_name   = "s3719633-assignment-2-key"
  public_key = file("~/keys/ec2-key.pub")
}

# resource "aws_launch_configuration" "todo_app_ec2" {
#   name            = "todo_app_web_config"
#   image_id        = "ami-0d5eff06f840b45e9"
#   instance_type   = "t2.micro"
#   security_groups = [aws_security_group.allow_http_ssh.id]

#   user_data = data.template_cloudinit_config.config.rendered

#   
# }

resource "aws_instance" "todo_app_ec2" {
  ami             = "ami-0d5eff06f840b45e9"
  instance_type   = "t2.micro"
  security_groups = [aws_security_group.allow_http_ssh.id]
  key_name        = aws_key_pair.deployer.key_name
  subnet_id       = aws_subnet.private_az1.id
}