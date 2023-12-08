resource "aws_key_pair" "jenkins_key" {
  key_name   = "id_rsa"
  public_key = file("./id_rsa.pub")
}

resource "aws_instance" "jenkins_instance" {
  ami                    = "ami-0fc5d935ebf8bc3bc"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.jenkins_key.key_name
  security_groups        = ["sg-050ff1c2c736a22d8"]
  subnet_id              = "subnet-0f4f89687422670f3"
  associate_public_ip_address = true

  connection {
    type        = "ssh"
    user        = "ubuntu"  # Replace with your appropriate username
    private_key = file("./id_rsa")
    host        = aws_instance.jenkins_instance.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "touch hello.txt",
      "echo helloworld remote provisioner >> hello.txt",
    ]
  }  
}