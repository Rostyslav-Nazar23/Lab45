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

  user_data = <<EOF
#!/bin/bash

sudo apt update
sudo apt install apt-transport-https curl gnupg-agent ca-certificates software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -aG docker $USER
newgrp docker
sudo docker run -d --name watchtower -e WATCHTOWER_POLL_INTERVAL=30 -v /var/run/docker.sock:/var/run/docker.sock containrrr/watchtower
sudo docker run -dp 80:80 --name web rostyslavnazar23/lab45:main

EOF

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
