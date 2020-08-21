# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "kp_instances" {
  key_name = "kp_instances"
  public_key = file("./ssh-keys/id_rsa_instances.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "sg_windows_instance" {
  name   = "sg_windows_instance"
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

resource "aws_instance" "windows_instance" {
  ami                         = var.amis[var.region] 
  instance_type               = var.instance_type
  key_name                    = "kp_instances"
  vpc_security_group_ids      = [ aws_security_group.sg_windows_instance.id ]
  subnet_id                   = aws_subnet.subnet_example.id
  private_ip                  = "${var.net_prefix}.${var.windows_instance_ip}"
  # si nécessaire, une ip publique
  associate_public_ip_address = "true"
  user_data                   = file("init_windows.sh")
  tags = {
    Name = "windows_instance"
  }
}


output "windows_instance_ip" {
  value = "${aws_instance.windows_instance.*.public_ip}"
}
output "windows_instance_private_ip" {
  value = "${aws_instance.windows_instance.*.private_ip}"
}