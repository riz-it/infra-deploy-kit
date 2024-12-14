# terraform {
#   backend "s3" {
#     key                         = "terraform.tfstate"
#     region                      = "us-east-1"
#     skip_credentials_validation = true
#     skip_region_validation      = true
#     skip_requesting_account_id  = true
#     skip_metadata_api_check     = true
#     skip_s3_checksum            = true
#   }
# }

module "git-repository" {
  source              = "../_modules/gitlab/git-repository"
  gitlab_access_token = var.gitlab_access_token
  repository_list     = var.repository_list
}

module "security-group" {
  source         = "../_modules/aws/security-group"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = var.aws_region
  aws_vpc_id     = var.aws_vpc_id
  sg_list        = var.sg_list
}

module "key-pair" {
  source         = "../_modules/aws/key-pair"
  aws_access_key = var.aws_access_key
  aws_secret_key = var.aws_secret_key
  aws_region     = var.aws_region
  key_pair_name  = var.key_pair_name
}

module "instance_ec2" {
  source               = "../_modules/aws/ec2"
  aws_access_key       = var.aws_access_key
  aws_secret_key       = var.aws_secret_key
  aws_region           = var.aws_region
  ec2_list             = var.ec2_list
  security_group_names = module.security-group.security_group_names
  key_pair_name        = var.key_pair_name
}

resource "null_resource" "create_ansible_inventory" {
  provisioner "local-exec" {
    command = <<-EOT
      cat <<EOL > inventory.ini
      [vm]
      ${join("\n", module.instance_ec2.ec2_public_ip)}
      EOL
    EOT
  }
}


resource "null_resource" "ansible" {
  provisioner "local-exec" {
    command = "sleep 80; ANSIBLE_HOST_KEY_CHECKING=false ansible-playbook -i inventory.ini ansible-playbook/setup-playbook.yml -u ${var.aws_user} --private-key ${var.key_pair_name}_pem"
  }
  depends_on = [null_resource.create_ansible_inventory]

}