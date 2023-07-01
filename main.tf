resource "aws_instance" "prov-test" {
  ami = "ami-0f5ee92e2d63afc18"
  instance_type = "t2.micro"
  key_name = "mumbai-key"
 
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/saikrishna/.ssh/id_rsa")
    host = self.public_ip
  }
  
  provisioner "file" {
    source = "${path.module}/script.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "/tmp/script.sh",
    ]
  }
}


