resource "aws_elb" "elb" {
  subnets  =["${module.vpc.subnet}"]
  
}
