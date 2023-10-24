
# data "templatefile" "hostname_init" {
#   template = file("${path.module}/script.tftpl")
#   vars = {
#     admin_password = var.admin_password
#     host_name = var.host_name
#   }
# }

data "aws_ami" "windows" {
  most_recent = true
  
  filter {
       name   = "virtualization-type"
       values = ["hvm"]
  }

  filter {
    name   = "name"
    values = ["Windows_Server-2019-English-Full-Base-*"]
  }
}

resource "aws_instance" "golfzon-windows" {
  ami           = data.aws_ami.windows.id
  instance_type = "t3.micro"

  ## network interface for ip addrs attachment dynamically
  network_interface {
    network_interface_id = aws_network_interface.golfzon-nic.id
    device_index         = 0
  }

  key_name = "Terraform-PoV"
  user_data = templatefile("${path.module}/script.tftpl", { 
    admin_password = var.admin_password,
    host_name = var.host_name
  })

  tags = {
    Name = "${var.prefix}-ec2"
  }
}

## network interface for instance: 
resource "aws_network_interface" "golfzon-nic" {
  subnet_id   = aws_subnet.golfzon-subnet.id
  private_ips = [var.priv_ip]
  security_groups = [aws_security_group.win.id]

  tags = {
    Name = "${var.prefix}-nic"
  }
}

## elastic ip: attach to golfzon-nic for instance && associate private ip for instance
resource "aws_eip" "golfzon-eip" {
  domain                    = "vpc"
  network_interface         = aws_network_interface.golfzon-nic.id
  associate_with_private_ip = var.priv_ip

  tags = {
    Name = "${var.prefix}-eip"
  }

  depends_on = [
    aws_instance.golfzon-windows
  ]
}

## test vpc: golfzon-vpc (10.70.0.0/16)
resource "aws_vpc" "golfzon-vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "${var.prefix}-vpc"
  }
}

## test subnet on golfzon-vpc: golfzon-subnet (10.70.1.0/24)
resource "aws_subnet" "golfzon-subnet" {
  vpc_id            = aws_vpc.golfzon-vpc.id
  cidr_block        = var.subnet_cidr
  availability_zone = "ap-northeast-2a"

  tags = {
    Name = "${var.prefix}-pubsbn"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.golfzon-vpc.id

  tags = {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "rt_igw" {
  vpc_id = aws_vpc.golfzon-vpc.id

  route {
    cidr_block = "0.0.0.0/0" 
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "${var.prefix}-rt-igw"
  }  
}

resource "aws_route_table_association" "rt_ass" {
  subnet_id      = aws_subnet.golfzon-subnet.id
  route_table_id = aws_route_table.rt_igw.id
}


