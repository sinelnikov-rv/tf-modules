variable "cluster_identifier" {
  default = "test"
  type = "string"
}
variable "db_name" {
  default = "test"
}
variable "root_name" {
  default = "root"
}
variable "root_pass" {
  
}
variable "min_capacity" {
  default = "2"
}
variable "max_capacity" {
  default = "4"
}
variable "sg_db" {
  type = "list"
}
variable "subnets" {
  
}



