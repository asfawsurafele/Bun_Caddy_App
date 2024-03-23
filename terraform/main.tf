module "vpc" {
  source       = "./vpc"
  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
  home_net     = var.home_net
  aws_region   = var.aws_region
}

module "sg"{
  source = "./securitygroup"
  name = "mod_demo_sg"
  description = "Allows ssh, web, and port 5000 ingress access and all egress"
  project_name = var.project_name
  vpc_id = module.vpc.vpc.id
  ingress_rules = [
    {
      description = "ssh access from home"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.home_net
      rule_name = "ssh_access_home"
    },
    {
      description = "ssh access from bcit"
      ip_protocol = "tcp"
      from_port = 22
      to_port = 22
      cidr_ipv4 = var.bcit_net
      rule_name = "ssh_access_bcit"
    },
    {
      description = "web access from home"
      ip_protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_ipv4 = var.home_net
      rule_name = "web_access_home"
    },
    {
      description = "web access from bcit"
      ip_protocol = "tcp"
      from_port = 80
      to_port = 80
      cidr_ipv4 = var.bcit_net
      rule_name = "web_access_bcit"
    }
   ]
  egress_rules = [ 
    {
      description = "allow all egress traffic"
      ip_protocol = "-1"
      from_port = null 
      to_port = null 
      cidr_ipv4 = "0.0.0.0/0"
      rule_name = "allow_all_egress"
    }
   ]
}

# -----------------------------------------------------------------------------
# get the most recent ami for ubuntu 23.04
# -----------------------------------------------------------------------------
data "aws_ami" "ubuntu" {
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami
  most_recent = true
  # this is the owner id for Canonical - the publisher of Ubuntu
  owners = ["099720109477"]

  filter {
    name = "name"
    # this is a glob expression - the * is a wildcard - that matches  the most
    # recent ubuntu 23.04 image x86 64-bit server image
    values = ["ubuntu/images/hvm-ssd/ubuntu-lunar-23.04-amd64-server-*"]
  }
}

# -----------------------------------------------------------------------------
# create an ssh key pair
# -----------------------------------------------------------------------------
module "ssh_key" {
  source = "./sshkeygen"
  key_name = var.ssh_key_name
}

module "ec2_1" {
  source = "./ec2"
  project_name = var.project_name
  type = "t2.micro"
  aws_region = var.aws_region
  ami_id = data.aws_ami.ubuntu.id
  subnet_id = module.vpc.sn_2
  security_group_id = module.sg.id
  ssh_key_name = var.ssh_key_name
  availability_zone = var.availability_zones2

}

module "ec2_2" {
  source = "./ec2"
  project_name = var.project_name
  type = "t2.micro"
  aws_region = var.aws_region
  ami_id = data.aws_ami.ubuntu.id
  subnet_id = module.vpc.sn_1
  security_group_id = module.sg.id
  ssh_key_name = var.ssh_key_name
  availability_zone = var.availability_zones1

}


resource "local_file" "ansible_inventory" {
  content = templatefile("../ansible/templates/inventory.tmpl", {
    backend_ips = [
      {
        ansible_user = "ubuntu"
        ip       = module.ec2_1.ec2_instance[0].public_ip
      },
      {
        ansible_user = "ubuntu"
        ip       = module.ec2_2.ec2_instance[0].public_ip
      }
    ]
  })
  filename        = "../ansible/inventory/inventory.ini"
  file_permission = "0644"
}