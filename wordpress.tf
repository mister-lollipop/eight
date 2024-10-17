provider "aws" {
  region     = "us-west-1"
  access_key = "AKIAXYKJRXNGYUGG4BJA"
  secret_key = "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"
}

resource "aws_instance" "instance" {
  ami                         = "ami-0cf4e1fcfd8494d5b"
  instance_type               = "t2.medium"
  key_name                    = "keypair"
  vpc_security_group_ids      = [aws_security_group.securitygroup1.id]
  associate_public_ip_address = true
  user_data                   = file("data.sh")
  tags = {
    Name = "instance"
  }
}

#creating security group

resource "aws_security_group" "securitygroup1" {

  #inbound Rules
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "securitygroup1"
  }
}