provider "aws" {
  region = "us-east-1"
}


resource "aws_s3_bucket" "b" {
  bucket = "matrioska-kan"
  acl    = "private"
  force_destroy = true

  versioning {
    enabled = true
  }

  tags = {
    Name        = "beskar"
    Environment = "Stg"
  }
}

terraform {
  backend "s3" {
    bucket         = "matrioska-kan"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}


resource "aws_instance" "monitoring" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t3.medium"
  key_name        = "k8s"
  security_groups = [aws_security_group.sg.id]
  subnet_id       = aws_subnet.subnet[0].id 

  root_block_device {
    volume_size           = 25
    encrypted             = true
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "monitoring"
  }
}

resource "aws_launch_template" "ecs_lt" {
  name_prefix   = "ecs-template"
  image_id      = "ami-080e1f13689e07408"
  instance_type = "t3.micro"

  key_name               = "k8s"
  vpc_security_group_ids = [aws_security_group.sg.id]
  
  iam_instance_profile {
    name = "ecsInstanceRole"
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size = 30
      volume_type = "gp2"
    }
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "ecs-instance"
    }
  }

  user_data = filebase64("${path.module}/ecs.sh")
}
