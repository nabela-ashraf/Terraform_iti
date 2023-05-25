module "vpc" {
    source = "../vpc"
    name = "vpc"
    cidr_block = "10.0.0.0/16"
}

module "ec2" {
    source = "../ec2"
    name = "ec2"
    ami = "ami-0aa2b7722dc1b5612"
    instance_type = "t2.micro"
    subnet_id = module.vpc.public_subnet_id
    vpc_security_group_ids = [module.vpc.vpc_security_group_id]
}

module "security_group" {
    source = "../security_group"
    name = "security_group"
    vpc_id = module.vpc.vpc_id
}

module "load_balancer" {
    source = "../load_balancer"
    name = "load_balancer"
    internal = false
    tname = "loadbalncer"
}
