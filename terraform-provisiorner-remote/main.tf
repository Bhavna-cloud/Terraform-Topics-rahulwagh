provider "aws" {
  region                   = "us-east-1"
  shared_credentials_files = ["/home/bhavna/.aws/credentials"]
}

resource "aws_instance" "ec2_example" {

  ami                    = "ami-0e2c8caa4b6378d8c"
  instance_type          = "t2.micro"
  key_name               = "id_rsa"
  vpc_security_group_ids = [aws_security_group.main.id]


  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ubuntu"
    private_key = file("/home/bhavna/practice/ssh/id_rsa")
    timeout     = "4m"
  }
}


resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}


resource "aws_key_pair" "deployer" {
  key_name   = "id_rsa"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDeJpsit8MACLsgDZVW+EkuMIqyAQh2c/MrhAf07FbnhKNcGRwTS8/75+mrimgYWYB20octWA/unOya4ffzy2Tp0xP7BgwesMppIdpcxtK4EwYiIKGBlubeLt+KA9jQEOgxWYbffnNqaKGIKn7D55Dlbz75iP4S3FUP63/PyJSi50V/mMYa89J1b+X/Y65ssqi3mFvHZI5Yq8LvsA+v4xkam6T/q6eXD212tRfv54LqoxoMG4Xdf4UcrfwGajGMK4lbeJYyvbLT5qRxzT6qjr0zkmuXlG5P7Q9Mtb0xCOD/mpZstG4I4AEWOXVqPbBSL729wcxLtVACRFJg/01cNk6f bhavna@server.bhavna.local"
}
