output "vpc" {
    value = module.vpc.vpc_id
}
output "subnet_public" {
    value = module.vpc.public_subnet_id
}
output "subnet_private" {
    value = module.vpc.private_subnet_id
}
output "security_group" {
    value = module.security_group.vpc_security_group_id
}
output "ec2" {
    value = module.ec2.ec2_id
}