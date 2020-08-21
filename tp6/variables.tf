variable "region" {
   default = "us-east-1"
}

variable "subnet" {
   default = "192.168.0.0/24"
}

variable "net_prefix" {
   default = "192.168.0"
}

variable "windows_instance_ip" {
   default = "100"
}

variable "instance_type" {
   default = "t2.micro"
}

variable "amis" {
  type = map
  default = {
    "us-east-1" = "ami-1e542176"
  }
}
