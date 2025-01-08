provider "aws" {
   region     = "us-east-1"
   access_key = var.access_key
   secret_key = var.secret_key
}

resource "aws_instance" "ec2_example" {
    ami = "ami-0e2c8caa4b6378d8c"
    instance_type = "t2.micro"
    tags = {
      Name = "EC2 Instance with remote state"
    }
}

terraform {
    backend "s3" {
        bucket = "bhavna-terraform-s3-bucket"
        key    = "abc/terraform.tfstate"
        region     = "us-east-1"
        dynamodb_table = "dynamodb-state-locking"
    }
}
