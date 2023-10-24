variable "region" {
  type    = string
  default = "ap-northeast-2"
}

variable "priv_ip" {
  description = "customed private ip for instance"
  type        = string
}

variable "host_name" {
  description = "customed hostname for instance"
  type        = string
}

variable "admin_password" {
  description = "Initial Password for Windows Admin"
  type        = string
  default     = "golfzonaws1!"
}

## Terraform-PoC-9-ec2-Multi-vpc ##  10.60.0.0/16
variable "vpc_id" {
  description = "vpc id"
  type = string
  default = "vpc-09cd62d218db5f3a5"
}
## Terraform-PoC-9-ec2-Multi-vpc public subnet ## 10.60.0.0/20
variable "subnet_id" {
  default = "subnet-012d3f9fd2ab6b143"
}

variable prefix {
  default = "TF-PoC-04-stand-win"
}