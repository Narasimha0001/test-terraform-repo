resource "aws_instance" "web1" {
  ami           = "ami-04ec97dc75ac850b1" # Ubuntu 22.04 in ap-south-1 (change if needed)
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_1.id
  key_name      = "Narasimha"

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              echo "Hello from Web1" > /var/www/html/index.html
              systemctl start apache2
              EOF

  tags = { Name = "Narasimha's_WebServer1" }
}

resource "aws_instance" "web2" {
  ami           = "ami-007c433663055a1cc"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_2.id
  key_name      = "Narasimha" # Use your existing key-pair name

  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              apt update -y
              apt install -y apache2
              echo "Hello from Web2" > /var/www/html/index.html
              systemctl start apache2
              EOF

  tags = { Name = "Narasimha's_WebServer2" }
}