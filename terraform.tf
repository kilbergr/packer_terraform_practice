provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-west-2"
}

# Create a security group
resource "aws_security_group" "rebecca-secure" {
  name        = "aws_test"
  description = "Allow inbound traffic and sshing"
}

# Create rules for security group
resource "aws_security_group_rule" "allow_ssh" {
  type            = "ingress"
  from_port       = 22
  to_port         = 22
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.rebecca-secure.id}"
}

resource "aws_security_group_rule" "allow_8000" {
  type            = "ingress"
  from_port       = 8000
  to_port         = 8000
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.rebecca-secure.id}"
}

resource "aws_security_group_rule" "allow_80" {
  type            = "ingress"
  from_port       = 80
  to_port         = 80
  protocol        = "tcp"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.rebecca-secure.id}"
}

resource "aws_security_group_rule" "all_egress" {
  type            = "egress"
  from_port       = 0
  to_port         = 0
  protocol        = "-1"
  cidr_blocks     = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.rebecca-secure.id}"
}

# Create two instances both with same security group based off same ami
# Create a new instance
resource "aws_instance" "rebecca-1" {
  ami           = "ami-02a3b57b"
  key_name      = "rebecca"
  instance_type = "t2.micro"
  security_groups = [
        "${aws_security_group.rebecca-secure.name}",
    ]
}

# Create a new instance
resource "aws_instance" "rebecca-2" {
  ami           = "ami-02a3b57b"
  key_name      = "rebecca"
  instance_type = "t2.micro"
  security_groups = [
        "${aws_security_group.rebecca-secure.name}",
    ]
}

# Create a new load balancer
resource "aws_elb" "terraform-resource-practice" {
  name               = "rebecca-terraform-elb"
  availability_zones = ["us-west-2a", "us-west-2b", "us-west-2c"]

  listener {
    instance_port     = 8000
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:8000/show_instance/"
    interval            = 30
  }

  instances                   = ["${aws_instance.rebecca-1.id}", "${aws_instance.rebecca-2.id}"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags {
    Name = "rebecca-terraform-elb"
  }
}