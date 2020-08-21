# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "kp_instances" {
  key_name = "kp_instances"
  public_key = file("./ssh-keys/id_rsa_instances.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "sg_nginx_instance" {
  name   = "sg_nginx_instance"
  vpc_id = aws_vpc.vpc_example.id
  # autorise http de partout
  # ce n'est qu'un example d'application possible
  ingress {
    from_port   = "80"
    to_port     = "80"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # autorise icmp (ping)
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "nginx_instance" {
  ami                         = var.amis[var.region] 
  instance_type               = var.instance_type
  key_name                    = "kp_instances"
  vpc_security_group_ids      = [ aws_security_group.sg_internal.id,
                                  aws_security_group.sg_nginx_instance.id ]
  subnet_id                   = aws_subnet.subnet_example.id
  private_ip                  = "${var.net_prefix}.${var.nginx_instance_ip}"
  # si nécessaire, une ip publique
  associate_public_ip_address = "true"
  user_data                   = file("init_nginx.sh")
  tags = {
    Name = "nginx_instance"
  }
}

resource "aws_instance" "apache_instance" {
  count = var.apache_count
  ami                         = var.amis[var.region] 
  instance_type               = var.instance_type
  key_name                    = "kp_instances"
  vpc_security_group_ids      = [ aws_security_group.sg_internal.id ]
  subnet_id                   = aws_subnet.subnet_example.id
  private_ip                  = "${var.net_prefix}.${count.index + 101}"
  # pas d'ip publique... généralement
  associate_public_ip_address = "false"
  # ou bien un init différent (dépend du style de cluster)
  user_data                   = file("init_apache.sh")
  tags = {
    Name = "apache_instance-${count.index + 1}"
  }
}

resource "aws_instance" "MariaDB" {
   # Ubuntu 18.04 fournie par AWS
   ami = "ami-0bcc094591f354be2"
   instance_type = "t2.micro"
   key_name = "kp_instances"
   vpc_security_group_ids = [ aws_security_group.sg_internal.id ]
   subnet_id = aws_subnet.subnet_example.id
   private_ip = "${var.net_prefix}.${var.mariadb_instance_ip}"
   associate_public_ip_address = "true"
   user_data = file("init_mariadb.sh")
   tags = {
     Name = "MariaDB"
   }
}

output "nginx_instance_ip" {
  value = "${aws_instance.nginx_instance.*.public_ip}"
}

output "apache_instance_private_ip" {
  value = "${aws_instance.apache_instance.*.private_ip}"
}

output "MariaDB_instance_private_ip" {
   value = "${aws_instance.MariaDB.*.private_ip}"
}
