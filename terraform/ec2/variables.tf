variable "project_name" {
  description = "Project name"
}

variable "type" {
  description = "Instance type"
  default     = "t2.micro"
}

variable "instance_count" {
  description = "Number of instances"
  default     = 1
}

variable "availability_zone" {
  description = "Availability zones for EC2 instances"
}



variable "aws_region" {
  description = "AWS region"
}

variable "ami_id" {
  description = "AMI ID"
}

variable "subnet_id" {
  description = "IDs of the subnets where EC2 instances will be deployed"
}

variable "security_group_id" {
  description = "The security group to launch the instance in"
}

variable "ssh_key_name" {
  description = "AWS SSH key name"
  default     = "acit_4640_202410"
}

variable "instance_name_1" {
  description = "Name tag for EC2 instances"
  default     = "as2_instance"
}


