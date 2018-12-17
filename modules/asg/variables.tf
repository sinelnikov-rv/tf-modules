variable "ami" {
  default = "ami-0627e141ce928067c"
}
variable "type" {
  default = "t2.micro"
}
variable "ecs_instance_profile" {
  
}
variable "key_name" {
  default = "macbook"
}
variable "security_groups" {
  type = "list"
}
variable "name" {
  default = "test"
}
variable "subnets" {
  type = "list"
}




