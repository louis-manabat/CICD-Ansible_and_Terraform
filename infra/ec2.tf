resource "aws_key_pair" "deployer" {
  key_name   = "s3719633-assignment-2-key"
  public_key = file("~/keys/ec2-key.pub")
}