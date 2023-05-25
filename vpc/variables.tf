variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  type = map
  default = {
    "public-1" : "10.0.0.0/24"
    "public-2" : "10.0.2.0/24"
  }
}

variable "private_subnet_cidr" {
  type = map
  default = {
    "private-1" : "10.0.1.0/24"
    "private-2" : "10.0.3.0/24"
  }
}

variable "all_route" {
  type = string
  default = "0.0.0.0/0"
}