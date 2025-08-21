# provider "aws" {
#   region = "eu-west-3"
# }

# resource "aws_s3_bucket" "my_bucket" {
#   bucket = "narasimha-bucket-for-training200825"   # must be globally unique
#   force_destroy = true   # allows bucket to be deleted even if it has objects

#   tags = {
#     Name        = "MyTrainingBucket"
#     Environment = "Dev"
#   }
# }


provider "aws" {
  region = "eu-west-3" # Change to your assigned region
}

resource "aws_security_group" "ec2_sg" {
  name        = "Bugbusters-terraform"
  description = "Allow SSH, HTTP, and custom 8080"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow custom app port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "my_ec2" {
  ami           = "ami-04ec97dc75ac850b1" # Ubuntu 22.04 LTS in ap-south-1 (Mumbai). Change if in another region
  instance_type = "t3.micro"
  key_name      = "Narasimha" # Use your existing key-pair name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "Terraform-EC2-Lab-Ubuntu"
  }

  depends_on = [aws_security_group.ec2_sg]
}

output "instance_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.my_ec2.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.my_ec2.id
}
output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.ec2_sg.id
}
