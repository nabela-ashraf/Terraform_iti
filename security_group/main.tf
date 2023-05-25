#creating the secuirity group
resource "aws_security_group" "vpc_secuirity" {
  name        = "vpc_secuirity"
  description = "secuirity group for the vpc"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    description      = "HTTPS"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = [var.all_routes]
    ipv6_cidr_blocks = [var.all_routes_ipv6]
  }
  ingress {
    description      = "HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = [var.all_routes]
    ipv6_cidr_blocks = [var.all_routes_ipv6]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = [var.all_routes]
    ipv6_cidr_blocks = [var.all_routes_ipv6]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.all_routes]
    ipv6_cidr_blocks = [var.all_routes_ipv6]
  }

  tags = {
    Name = "vpc_secuirity"
  }
}
