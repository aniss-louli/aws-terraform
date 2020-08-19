# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "tfkeypair10" {
    key_name = "tfkeypair10"
    # généré par ssh-keygen ...
    public_key = file("/media/backup/aws-terraform/tp3/ssh-keys/id_rsa_tfkeypair10.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "reseau_interne" {
   name = "reseau_interne"
   vpc_id = aws_vpc.reseau_interne.id
   # en entrée
   # autorise communication avec MariaDB
   ingress {
     from_port = "0"
     to_port   = "65535"
     protocol  = "all"
     cidr_blocks = [ "192.168.77.20/32" ]
   }
   # autorise communication avec Wordpress
   ingress {
     from_port = "0"
     to_port   = "65535"
     protocol  = "all"
     cidr_blocks = [ "192.168.77.10/32" ]
   }
   # autorise http de partout
   ingress {
     from_port = "80"
     to_port   = "80"
     protocol  = "tcp"
     cidr_blocks = [ "0.0.0.0/0" ]
   }
}

resource "aws_instance" "Wordpress" {
   # Ubuntu 18.04 fournie par AWS
   ami = "ami-0bcc094591f354be2"
   instance_type = "t2.micro"
   key_name = "tfkeypair10"
   vpc_security_group_ids = [ aws_security_group.reseau_interne.id ]
   subnet_id = aws_subnet.subnet_example.id
   private_ip = "192.168.77.10"
   associate_public_ip_address = "true"
   user_data = file("instance_init1.sh")
   tags = {
     Name = "Wordpress"
   }
}

resource "aws_instance" "MariaDB" {
   # Ubuntu 18.04 fournie par AWS
   ami = "ami-0bcc094591f354be2"
   instance_type = "t2.micro"
   key_name = "tfkeypair1"
   vpc_security_group_ids = [ aws_security_group.reseau_interne.id ]
   subnet_id = aws_subnet.subnet_example.id
   private_ip = "192.168.77.20"
   associate_public_ip_address = "true"
   user_data = file("instance_init2.sh")
   tags = {
     Name = "MariaDB"
   }
}

output "Wordpress_ip" {
   value = "${aws_instance.Wordpress.*.public_ip}"
}
output "MariaDB_ip" {
   value = "${aws_instance.MariaDB.*.public_ip}"
}