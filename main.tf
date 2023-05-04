terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "3.74.0"
    }
  }

  required_version = ">= 1.2.0"

  cloud {
    organization = "shutuper"

    workspaces {
      name = "iit-lab-6"
    }
  }
}

resource "aws_instance" "lab6" {
  ami                    = "ami-0d9fad4f90eb14fc3"
  instance_type          = "t2.micro"
  key_name               = "teraform-key"
  vpc_security_group_ids = [aws_security_group.default-sec-group.id]

  user_data = file("user_data.sh")

  lifecycle {
    ignore_changes = [user_data]
  }

  tags = {
    Name = "IIT-lab-6"
  }
}

resource "aws_security_group" "default-sec-group" {
  name = "default security group"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
