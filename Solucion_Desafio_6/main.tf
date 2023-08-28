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

# Create a VPC
module "vpc" {
  source          = "terraform-aws-modules/vpc/aws"
  version         = "5.1.1"
  cidr            = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.128.0/20", "10.0.144.0/20"]
  public_subnets  = ["10.0.0.0/20", "10.0.16.0/20"]
  tags = {
    mail = "orpimel@gmail.com"
  }
}

# Create a Security Group
resource "aws_security_group" "server_linux_rdp_sg" {
  vpc_id = module.vpc.vpc_id
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

# Create Two Resources - Instance
resource "aws_instance" "linux_server_ins" {
  count = 2
  # ami => Amazon Linux 2023 AMI 2023.1.20230825.0 x86_64 HVM kernel-6.1
  ami                         = "ami-053b0d53c279acc90"
  instance_type               = "t2.micro"
  subnet_id                   = module.vpc.public_subnets[count.index] # Public Subnet *important*
  key_name                    = "devops"
  vpc_security_group_ids      = [aws_security_group.server_linux_rdp_sg.id]
  associate_public_ip_address = true # needed for ssh connection
  user_data                   = <<-EOF
                                  #!/bin/bash
                                  sudo apt update -y
                                  sudo apt install -y apache2
                                  sudo systemctl enable apache2
                                  sudo chown ubuntu: /var/www/html
                                  echo -e "Hostname: $(hostname) \n" > /var/www/html/index.html
                                  (echo -n "Region: " ; curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}') >> /var/www/html/index.html
                                  sudo systemctl start apache2
                                EOF
  tags = {
    mail = "orpimel@gmail.com"
  }
}

#Create a Target Group
resource "aws_lb_target_group" "server_linux_rdp_tg" {
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
  tags = {
    mail = "orpimel@gmail.com"
  }
}

# Attach Instances to Target Group
resource "aws_lb_target_group_attachment" "server_linux_rdp_tg_attachment" {
  count            = 2
  target_group_arn = aws_lb_target_group.server_linux_rdp_tg.arn
  target_id        = aws_instance.linux_server_ins[count.index].id
  port             = 80
}

# Create a Load Balancer
resource "aws_lb" "server_linux_rdp_lb" {
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.server_linux_rdp_sg.id]
  subnets            = [for subnet in module.vpc.public_subnets : subnet]
  tags = {
    mail = "orpimel@gmail.com"
  }
}

# Create a Listener
resource "aws_lb_listener" "server_linux_rdp_lb_listener" {
  load_balancer_arn = aws_lb.server_linux_rdp_lb.arn
  port              = "80"
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.server_linux_rdp_tg.arn
  }
  tags = {
    mail = "orpimel@gmail.com"
  }
}
