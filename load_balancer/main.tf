#creating application load balancer
resource "aws_lb" "loadbalncer" {
    name = var.name
    internal = var.internal
    load_balancer_type = "application"
    security_groups = [aws_security_group.vpc_secuirity.id]
    subnets = [aws_subnet.public_subnet.id]
}

#creating target group
resource "aws_lb_target_group" "targetgroup" {
    name = var.tname
    port = 80
    protocol = "HTTP" 
    vpc_id = aws_vpc.vpc.id
}

#creating listener
resource "aws_lb_listener" "listener" {
    load_balancer_arn = aws_lb.loadbalncer.arn
    port = "80"
    protocol = "HTTP"
    default_action {
        target_group_arn = aws_lb_target_group.targetgroup.arn
        type = "forward"
    }
}