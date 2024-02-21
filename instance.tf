resource "aws_key_pair" "aws_test_key" {
  key_name   = "my_key"
  public_key = file("testkey.pub")
}

resource "aws_instance" "test_instance" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.testvpc-pub-sub1.id
  key_name               = aws_key_pair.aws_test_key.key_name
  vpc_security_group_ids = [aws_security_group.test-sec-grp.id]
  tags = {
    Name     = "test_instance"
    Label    = "Terra learn"
    Exercise = "Multi resources"
  }
}

resource "aws_instance" "test_instance2" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.testvpc-pub-sub2.id
  key_name               = aws_key_pair.aws_test_key.key_name
  vpc_security_group_ids = [aws_security_group.test-sec-grp.id]
  tags = {
    Name = "test_instance2"
  }
}

resource "aws_instance" "test_instance3" {
  ami                    = var.AMIS[var.REGION]
  instance_type          = "t2.micro"
  subnet_id              = aws_subnet.testvpc-priv-sub1.id
  key_name               = aws_key_pair.aws_test_key.key_name
  vpc_security_group_ids = [aws_security_group.test-sec-grp.id]
  tags = {
    Name = "test_instance3"
  }
}

# Has to be in the same zone with the instances it attachs to
resource "aws_ebs_volume" "test_volume" {
  availability_zone = var.ZONE1
  size              = 3

  tags = {
    Name = "Extra volume for test_instance"
  }
}

resource "aws_volume_attachment" "attch_test_volume" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.test_volume.id
  instance_id = aws_instance.test_instance.id
}

output "PublicIP-test_instance1" {
  value = aws_instance.test_instance.public_ip
}

output "PublicIP-test_instance2" {
  value = aws_instance.test_instance2.public_ip
}

output "PublicIP-test_instance3" {
  value = aws_instance.test_instance3.public_ip
}