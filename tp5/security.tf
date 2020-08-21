resource "aws_security_group" "sg_internal" {
  # SG pour communication entre instances
  # en particulier entre bastion et instance
  # on autorise TOUT (parque je le veux)
  name   = "sg_internal"
  vpc_id = aws_vpc.vpc_example.id
  ingress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = [ var.subnet ]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}