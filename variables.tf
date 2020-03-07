variable "region" {
    description = "The AWS region to create resources in."
    default = "ca-central-1"
}

# TODO: support multiple availability zones, and default to it.
variable "availability_zone" {
    description = "The availability zone"
    default = "ca-central-1a"
}

variable "ecs_cluster_name" {
    description = "The name of the Amazon ECS cluster."
    default = "eis"
}

variable "amis" {
    description = "Which AMI to spawn. Defaults to the AWS ECS optimized images."
    # TODO: support other regions.
    default = {
        ca-central-1 = "ami-05f3d80c6c53dc654" #amzn-ami-2018.03.20200218-amazon-ecs-optimized
    }
}


variable "autoscale_min" {
    default = "1"
    description = "Minimum autoscale (number of EC2)"
}

variable "autoscale_max" {
    default = "10"
    description = "Maximum autoscale (number of EC2)"
}

variable "autoscale_desired" {
    default = "1"
    description = "Desired autoscale (number of EC2)"
}


variable "instance_type" {
    default = "t2.micro"
}

#variable "ssh_pubkey_file" {
#    description = "Path to an SSH public key"
#    default = "~/.ssh/id_rsa.pub"
#}
