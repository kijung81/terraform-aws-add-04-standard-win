variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "priv_ip" {
  description = "customed private ip for instance"
  type        = string
  default     = "10.70.1.4"
}

variable "host_name" {
  description = "customed hostname for instance"
  type        = string
  default     = "tf-poc-win"
}

variable "admin_password" {
  description = "Initial Password for Windows Admin"
  type        = string
  default     = "golfzonaws1!"
}

## Terraform-PoC-9-ec2-Multi-vpc ##  10.70.0.0/16
variable "vpc_cidr" {
  description = "vpc cidr"
  type = string
  default = "10.70.0.0/16"
}
## Terraform-PoC-9-ec2-Multi-vpc public subnet ## 10.70.1.0/24
variable "subnet_cidr" {
  default = "10.70.1.0/24"
}

variable prefix {
  default = "TF-PoC-04-stand-win"
}