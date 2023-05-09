variable "region" {
    description = "AWS Region to deploy to"
    type = string
    default = "eu-west-1"
}

variable "environment" {
    description = "Environment name, i.e. dev, qa, us-prod. Should be lowercase"
    type = string
    default = "prod"
}

variable "db_password" {
    description = "Password for RDS postgres"
    type = string
}

variable "domain" {
    description = "Domain"
    type = string
}

variable "backend_auto_scaling_min" {
    description = "Minimum ec2 instances for backend auto-scaling group"
    type = string
    default = 1
}

variable "backend_auto_scaling_max" {
    description = "Maximum ec2 instances for backend auto-scaling group"
    type = string
    default = 1
}

variable "ecs_ami_image" {
    description = "AMI used for EC2 instances on ECS"
    type = string
    default = "ami-005b5f3941c234694"
}

variable "ecs_instance_type" {
    description = "Instance type used by ECS cluster"
    type = string
    default = "t4g.nano"
}

variable "rds_instance_type" {
    description = "Instance type used by RDS"
    type = string
    default = "db.t4g.micro"
}