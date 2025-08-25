resource "aws_instance" "app_server" {
  ami           = "ami-02d7ced41dff52ebc"  # Amazon Linux 2 (check region)
  instance_type = "t2.micro"
  subnet_id     = "subnet-0777ff342e99e8f45"
  key_name      = "Narasimha"
  security_groups = ["sg-0f9b6c2280f54495b"]

  tags = {
    Name = "Narasimha"  # unique per student
  }
}
provider "aws" {
  region = "eu-west-3"
  
}

output "app_server_ip" {
  value = aws_instance.app_server.public_ip
}