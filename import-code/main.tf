resource "aws_instance" "web" {
  ami                                  = "ami-033a1ebf088e56e81"
  associate_public_ip_address          = true
  availability_zone                    = "us-east-1d"
  instance_type                        = "t2.micro"
  ipv6_address_count                   = 0
  key_name                             = "windows-key"
  monitoring                           = false
  security_groups                      = ["launch-wizard-2"]
  subnet_id                            = "subnet-0084c1614e0b43e0c"
  tags = {
    Name = "MyName"
  }
}
