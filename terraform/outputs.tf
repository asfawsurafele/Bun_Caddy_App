output "vpc" {
  value = module.vpc.vpc.id
}

output "sn_1" {
  value = module.vpc.sn_1.id

}

output "gw_1" {
  value = module.vpc.gw_1.id
}

output "rt_1" {
  value = module.vpc.rt_1.id
}

output "sg_1" {
  value = module.sg.id
}

output "ec2_instance_id" {
  value = module.ec2_1.ec2_instance[0].id
}

output "ec2_instance_public_ip" {
  value = module.ec2_1.ec2_instance[0].public_ip
}

output "ec2_instance_public_dns" {
  value = module.ec2_1.ec2_instance[0].public_dns
}

output "ec2_instance_id_2" {
  value = module.ec2_2.ec2_instance[0].id
}

output "ec2_instance_public_ip_2" {
  value = module.ec2_2.ec2_instance[0].public_ip
}

output "ec2_instance_public_dns_2" {
  value = module.ec2_2.ec2_instance[0].public_dns
}

output "ssh_pub_key_file" {
  value = module.ssh_key.pub_key_file
}

output "ssh_priv_key_file" {
  value = module.ssh_key.priv_key_file
}