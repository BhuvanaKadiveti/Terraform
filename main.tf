provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "us-west-2"
}
resource "aws_instance" "example-1" {
    ami = "ami-08692d171e3cf02d6"
    instance_type ="t2.micro"
    key_name = "terraform-test"
    security_groups = ["AnsibleSG"]

    connection {
        type = "ssh"
        user = "ubuntu"
        private_key = "${file("./terraform-test.pem")}"
    }
    
    tags {
        Name = "Terraform-Test1"
    }  

    provisioner "remote-exec" {
        inline = ["sudo apt-get update -y",
                  "sudo apt-get install apache2 -y",
                  "sudo service apache2 start",
                  "sudo service apache2 status"
                 ]
        
    }  
}






