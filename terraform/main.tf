terraform {
  required_version = ">= 1.6.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

# Discover Amazon Linux 2023 AMI dynamically
data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["137112412989"] # Amazon
  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

# Key pair (use an existing key in your account)
# If you don't have one, create it in AWS Console and set var.key_name

# Security group
resource "aws_security_group" "web" {
  name        = "${var.project_prefix}-sg"
  description = "Allow SSH and HTTP"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = { Name = "${var.project_prefix}-sg" }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# ---------- M1: single instance ----------
resource "aws_instance" "app_single" {
  count         = var.milestone == 1 ? 1 : 0
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default.ids[0]
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  # Ensure Ansible has Python available
  user_data = <<-EOF
              #!/bin/bash
              dnf -y install python3
              EOF

  tags = { Name = "${var.project_prefix}-app-single" }
}

# ---------- M2/M3: three app instances ----------
resource "aws_instance" "app" {
  count         = var.milestone >= 2 ? 3 : 0
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default.ids[0]
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf -y install python3
              EOF

  tags = {
    Name = "${var.project_prefix}-app-${count.index + 1}"
    app_id = tostring(count.index + 1)
  }
}

# ---------- M3: load balancer instance (Nginx) ----------
resource "aws_instance" "lb" {
  count         = var.milestone >= 3 ? 1 : 0
  ami           = data.aws_ami.al2023.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnets.default.ids[0]
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.web.id]

  user_data = <<-EOF
              #!/bin/bash
              dnf -y install python3
              EOF

  tags = { Name = "${var.project_prefix}-lb" }
}
