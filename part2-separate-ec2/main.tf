########################################
# Security Group
########################################

resource "aws_security_group" "web_sg" {
  name = "separate-ec2-sg"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

########################################
# Frontend EC2
########################################

resource "aws_instance" "frontend_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("frontend-userdata.sh")

  tags = {
    Name = "Frontend-EC2"
  }
}

########################################
# Backend EC2
########################################

resource "aws_instance" "backend_ec2" {
  ami           = "ami-0f5ee92e2d63afc18"
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.web_sg.id]

  user_data = file("backend-userdata.sh")

  tags = {
    Name = "Backend-EC2"
  }
}
