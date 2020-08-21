resource "aws_key_pair" "kp_bastion" {
  key_name = "kp_bastion"
  # généré par ssh-keygen ...
  public_key = file("./ssh-keys/id_rsa_bastion.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "sg_bastion" {
  name   = "sg_bastion"
  vpc_id = aws_vpc.vpc_example.id
  # en entrée
  # autorise ssh de partout
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "tcp"
    # on pourrait mettre l'ip sortante de notre réseau d'organisation
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

resource "aws_instance" "bastion" {
  # Ubuntu 18.04 fournie par AWS
  ami                         = var.amis[var.region]
  instance_type               = var.bastion_type
  key_name                    = "kp_bastion"
  vpc_security_group_ids      = [ aws_security_group.sg_internal.id,
                                  aws_security_group.sg_bastion.id ]
  subnet_id                   = aws_subnet.subnet_example.id
  private_ip                  = var.bastion_ip
  associate_public_ip_address = "true"
  user_data                   = file("/media/backup/aws-terraform/tp4/init_bastion.sh")
  tags = {
    Name = "bastion"
  }
}

output "bastion_ip" {
  value = "${aws_instance.bastion.*.public_ip}"
}
output "bastion_private_ip" {
  value = "${aws_instance.bastion.*.private_ip}"
}