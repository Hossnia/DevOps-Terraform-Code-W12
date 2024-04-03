terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "4.61.0"
    }
  }
}

provider "aws" {
  
  region = "us-east-1"
}

resource "aws_instance" "demo1" {
  ami = "ami-033a1ebf088e56e81"
  instance_type = "t2.micro"
  key_name = "week12key"
}

resource "null_resource" "n1" {
    connection {
      type = "ssh"
      port = 22
      user = "ec2-user"
      host = aws_instance.demo1.public_ip
      private_key = file(local_file.ssh_key.filename)
    
    }

   provisioner "local-exec" {
    command = "echo ${aws_instance.demo1.public_ip} >> test.txt"
    #we can also replace "aws_instance.demo1" in the brackets by "self" bz we're positionned under the instance block
  }

  provisioner "remote-exec" {
    inline = [ 
        "sudo useradd hossnia1",
        "mkdir terraform1"
     ]
  }

  provisioner "file" {
    source = "week12key.pem"
    destination = "/tmp/week12key.pem"
  }
  depends_on = [ aws_instance.demo1 ]
}


