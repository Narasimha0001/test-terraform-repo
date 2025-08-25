resource "aws_instance" "jenkins" {
  ami           = "ami-02d7ced41dff52ebc" # Amazon Linux 2 AMI (check region)
  instance_type = "t2.medium"
  subnet_id     = aws_subnet.team_subnet.id
  key_name      = var.key_name
  security_groups = [aws_security_group.team_sg.id]

  tags = {
    Name = "${var.team_name}-jenkins"
  }
}

output "jenkins_ip" {
  value = aws_instance.jenkins.public_ip
}