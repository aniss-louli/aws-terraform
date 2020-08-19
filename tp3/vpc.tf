# Changer le nom reseau_interne pour un déploiement précis
# Adapter le réseau
resource "aws_vpc" "reseau_interne" {
   cidr_block = "192.168.77.0/24" # RFC 1918, réseau privé
}

# Changer le nom subnet_example pour un déploiement précis
# Adapter le réseau (voire en ajouter)
resource "aws_subnet" "subnet_example" {
   vpc_id = aws_vpc.reseau_interne.id # cf. ressource ci-dessus
   cidr_block = "192.168.77.0/24"
   map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "default" {
   vpc_id = aws_vpc.reseau_interne.id
}

resource "aws_route" "wan_access" {
   route_table_id  = aws_vpc.reseau_interne.main_route_table_id
   destination_cidr_block = "0.0.0.0/0"
   gateway_id = aws_internet_gateway.default.id
}

