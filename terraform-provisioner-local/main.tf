provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/bhavna/.aws/credentials"]
}

resource "aws_instance" "ec2_example" {

  ami                    = "ami-0e2c8caa4b6378d8c"
  instance_type          = "t2.micro"
  tags = {
        Name = "Terraform EC2"
    }

  provisioner "local-exec" {
    command = "touch hello.txt"
  }
}
  
