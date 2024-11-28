provider "aws" {
 region = var.region
 access_key = var.access_key
 secret_key = var.secret_key
}

variable "ports" {
type = list(number)
default = [80,8080,5432,3306,443]
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic and all outbound traffic"

 dynamic ingress {
  for_each = var.ports # go to variable ports for each value
    iterator =  port
    content {
    from_port        = port.value
    to_port          = port.value
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
   }
 }
}
