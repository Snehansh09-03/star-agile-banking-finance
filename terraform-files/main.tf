resource "aws_instance" "test-server" {
  ami = "ami-0bc691261a82b32bc"
  instance_type = "t2.micro"
  key_name = "Staragile"
  vpc_security_group_ids = ["sg-0c7b73297c52807d3"]
  connection {
     type = "ssh"
     user = "ubuntu"
     private_key = file("./Staragile.pem")
     host = self.public_ip
     }
  provisioner "remote-exec" {
     inline = ["echo 'wait to start the instance' "]
  }
  tags = {
     Name = "test-server"
     }
  provisioner "local-exec" {
     command = "echo ${aws_instance.test-server.public_ip} > inventory"
     }
  provisioner "local-exec" {
     command = "ansible-playbook /var/lib/jenkins/workspace/Banking-proj/terraform-files/ansibleplaybook.yml"
     }
  }
