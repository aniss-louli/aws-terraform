# Adapter le nom à l'usage
# un nom doit être unique pour un compte AWS
# donné
resource "aws_key_pair" "kp_instances" {
  key_name = "kp_instances"
  public_key = file("./ssh-keys/id_rsa_instances.pub")
}

# Adapter le nom à l'usage
resource "aws_security_group" "sg_instance_ex1" {
  name   = "sg_instance_ex1"
  vpc_id = aws_vpc.vpc_exemple.id
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

resource "aws_instance" "instance_ex1" {
  ami                         = var.amis[var.region] 
  instance_type               = var.instance_type
  key_name                    = "kp_instances"
  vpc_security_group_ids      = [ aws_security_group.sg_internal.id,
                                  aws_security_group.sg_instance_ex1.id ]
  subnet_id                   = aws_subnet.subnet_example.id
  private_ip                  = var.first_instance_ip
  # si nécessaire, une ip publique
  associate_public_ip_address = "true"
  user_data                   = file("instance_init1.sh")
  tags = {
    Name = "instance_ex1"
  }
}

resource "aws_instance" "node" {
  count = var.node_count
  ami                         = var.amis[var.region] 
  instance_type               = var.node_type
  key_name                    = "kp_instances"
  vpc_security_group_ids      = [ aws_security_group.sg_internal.id ]
  subnet_id                   = aws_subnet.subnet_example.id
  private_ip                  = "${var.net_prefix}.${count.index + 100}"
  # pas d'ip publique... généralement
  associate_public_ip_address = "false"
  # ou bien un init différent (dépend du style de cluster)
  user_data                   = file("instance_init1.sh")
  tags = {
    Name = "node-${count.index + 1}"
  }
}



output "instance_ex1_ip" {
  value = "${aws_instance.instance_ex1.*.public_ip}"
}

output "instance_ex1_private_ip" {
  value = "${aws_instance.instance_ex1.*.private_ip}"
}

output "nodes_private_ip" {
  value = "${aws_instance.node.*.private_ip}"
}
