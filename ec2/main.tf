#install nginx on public instances
resource "aws_instance" "puplic_nginx" {
  count = 2
  ami = var.ami
  vp_id = aws_vpc.vpc.id
  subnet_id = aws_subnet.public_subnet.id
  instance_type = var.instance_type
  key_name = var.key_name
  tags = {
    Name = "puplic_nginx"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
    
  }

#install nginx on private instances
resource "aws_instance" "private_nginx" {
  count = 2
  ami = var.ami
  vp_id = aws_vpc.vpc.id
  subnet_id = aws_subnet.private_subnet.id
  instance_type = var.instance_type
  key_name = var.key_name
  tags = {
    Name = "private_nginx"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
  }
  
