terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.10.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Create a Resource - Elastic IP
resource "aws_eip" "devops_eip" {
  tags = {
    mail = "orpimel@gmail.com"
  }
}

# Associate an Elastic IP
resource "aws_eip_association" "windows_server_eip" {
  instance_id   = aws_instance.windows_server_ins.id
  allocation_id = aws_eip.devops_eip.id
}

# Create a VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.1"

  name = "devops_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  tags = {
    mail = "orpimel@gmail.com"
  }
}

# Create a Security Group
resource "aws_security_group" "server_windows_rdp_sg" {
  name        = "server_windows_rdp_sg"
  description = "RPD access to windows server"
  vpc_id      = module.vpc.vpc_id
  ingress {
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

# Create a Resource - Instance
resource "aws_instance" "windows_server_ins" {
  ami                         = "ami-069c45f40acdfe41e"
  instance_type               = "t2.micro"
  key_name                    = "devops"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.server_windows_rdp_sg.id]
  subnet_id                   = module.vpc.public_subnets[0]
  tags = {
    mail = "orpimel@gmail.com"
  }
}
