packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "sops_age_key" {
  type        = string
  description = "Sops Age secret key used to decrypt chef databags"
  sensitive   = true
}


source "amazon-ebs" "ubuntu" {
  ami_name                    = "linux-nginx-${formatdate("YYYY-MM-DD'T'hh.mm.ssZ", timestamp())}"
  subnet_id                   = "" # Change this to your subnet id
  source_ami                  = "ami-0261755bbcb8c4a84"
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  region                      = "us-east-1"
  ssh_username                = "ubuntu"
}

build {
  name    = "linux-nginx"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "shell" {
    script = "bootstrap.sh"

    environment_vars = [
      "SOPS_AGE_KEY=${var.sops_age_key}"
    ]
  }

  provisioner "breakpoint" {
    note = "Check if everything worked"
  }
}