variable "cluster_name" {
    type    = string
    default = "eks-aws-teleport-lab"
}

variable "cluster_region" {
    type = string 
    default = "us-east-1"
    description = "AWS region"
}
variable "namespace" {
    type    = string
    default = "teleoportlab"
}

variable "vpc_name" {
    type = string
    default = "teleport-vpc"
}
