
variable "region" {
  type = string
  default = "us-east-2"
}


variable "cluster-name" {
    type = string
    default = "myCluster"
  
}


variable "instance-types" {
    type = list(string)
    default = [ "t2.medium" ]
  
}

data "aws_availability_zones" "available" {
  state = "available"
}