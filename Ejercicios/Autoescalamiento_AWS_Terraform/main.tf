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
  ingress {
    from_port   = 22
    to_port     = 22
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

# Create an Autoscaling Group
module "asg" {
  source = "terraform-aws-modules/autoscaling/aws"

  name                = "my-asg"
  min_size            = 3
  max_size            = 3
  desired_capacity    = 3
  health_check_type   = "ELB"
  vpc_zone_identifier = module.vpc.public_subnets

  launch_template_name        = "my-template-name"
  launch_template_description = "Complete launch template example"
  update_default_version      = true

  instance_refresh = {
    strategy = "Rolling"
    preferences = {
      checkpoint_delay       = 600
      checkpoint_percentages = [35, 70, 100]
      instance_warmup        = 300
      min_healthy_percentage = 50
    }
    triggers = ["tag"]
  }

  image_id      = "ami-053b0d53c279acc90"
  instance_type = "t2.micro"
  key_name      = "devops"
  user_data     = base64encode("${file("config.sh")}")

  security_groups   = [aws_security_group.server_linux_rdp_sg.id]
  target_group_arns = [aws_lb_target_group.server_linux_rdp_tg.arn]

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [aws_security_group.server_linux_rdp_sg.id]
      associate_public_ip_address = true # Important!
    }
  ]

  tags = {
    mail = "orpimel@gmail.com"
  }
}

# Create a Target Group
resource "aws_lb_target_group" "server_linux_rdp_tg" {
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = module.vpc.vpc_id
  tags = {
    mail = "orpimel@gmail.com"
  }
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
