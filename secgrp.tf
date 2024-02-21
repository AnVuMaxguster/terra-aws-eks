resource "aws_security_group" "test-sec-grp" {
  name        = "test-secgrp"
  vpc_id      = aws_vpc.testvpc.id
  description = "Allow SSH connection from my public IP to instances of [basic VPC]"

  egress {
    # Value from 0 to 0 -> apply to all ports
    from_port = 0
    to_port   = 0
    # Value -1 -> apply to all protocols
    protocol = "-1"
    # Value 0.0.0.0/0 -> any IPs
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    # Port 22: SSH
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }
}