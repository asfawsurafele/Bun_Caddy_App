resource "aws_instance" "ec2_instance_" {
  count           = var.instance_count
  ami             = var.ami_id
  instance_type   = var.type
  key_name        = var.ssh_key_name
  subnet_id       = var.subnet_id.id
  availability_zone = var.availability_zone
  security_groups = [var.security_group_id]
  tags = {
    Name    = "${var.instance_name_1}-${count.index + 1}"
    Project = var.project_name
    Type    = "demo"
  }
}

