variable "region" {
   default = "us-east-1"
}

variable "subnet" {
   default = "192.168.0.0/24"
}

variable "bastion_ip" {
   default = "192.168.0.254"
}

variable "net_prefix" {
   default = "192.168.0"
}

variable "nginx_instance_ip" {
   default = "10"
}

variable "mariadb_instance_ip" {
   default = "20"
}

variable "bastion_type" {
   default = "t2.micro"
}

variable "instance_type" {
   default = "t2.micro"
}

variable "node_type" {
   default = "t2.micro"
}

variable "apache_count" {
   default = 5
}

variable "amis" {
  type = map
  default = {
    "us-east-1" = "ami-0bcc094591f354be2"
  }
}
