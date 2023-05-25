output "ec2_public_ip" {
    value = aws_instance.puplic_nginx.*.public_ip  
}