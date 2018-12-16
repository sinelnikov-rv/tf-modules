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
  default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]  
}