resource "aws_security_group" "win" {
  name        = "winsg"
  description = "ec2 win sg"
  vpc_id      = aws_vpc.golfzon-vpc.id

  ingress {
    description      = "rdp access"
    from_port        = 3389
    to_port          = 3389
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }  
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-win-sg"
  }
}