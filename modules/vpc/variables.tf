variable "vpc_cidr" {
  default = "192.168.0.0/16"
}
variable "name" {
  default = "test_vpc"
}
variable "ipv6" {
  default = false
}
variable "avz" {
  default = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]  
}