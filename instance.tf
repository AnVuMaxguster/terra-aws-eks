resource "aws_key_pair" "aws_test_key" {
  key_name       = "my_key"
  public_key = file("testkey.pub")
}

resource "aws_instance" "test_instance" {
  ami               = var.AMIS[var.REGION]
  instance_type     = "t2.micro"
  availability_zone = var.ZONE1
  key_name          = "my_key"
  # or
  # key_name = aws_key_pair.aws_test_key.key_name
  vpc_security_group_ids = ["sg-04c2adfbba1d458e2"]
  tags = {
    Label    = "Terra learn"
    Exercise = "Provisioning instance"
  }

  provisioner "file" {
    source      = "testscript.sh"
    destination = "/tmp/testscript.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod u+x /tmp/testscript.sh",
      "sudo /tmp/testscript.sh"
    ]
  }

  connection {
    user        = var.USER
    private_key = file("testkey")
    host        = self.public_ip
  }
}