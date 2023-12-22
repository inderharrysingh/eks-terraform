
// VPC 
resource "aws_vpc" "myVPC" {
  cidr_block = "10.0.0.0/16"

  enable_dns_support = true
  enable_dns_hostnames = true

}



// internet gateway
resource "aws_internet_gateway" "myIGW" {
  vpc_id = aws_vpc.myVPC.id 
}



// public Subnet 
resource "aws_subnet" "public-subnets" {
  vpc_id     = aws_vpc.myVPC.id
  cidr_block = "10.0.${count.index + 1}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index % length(data.aws_availability_zones.available.names)]
  map_public_ip_on_launch = true
  count = 4
}



// route table for public 
resource "aws_route_table" "myRouteTable" {
  vpc_id = aws_vpc.myVPC.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myIGW.id 
  }

}



// route able association
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public-subnets[count.index].id 
  route_table_id = aws_route_table.myRouteTable.id
  count = 4
}

