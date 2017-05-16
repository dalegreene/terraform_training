# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-f2b39792
#
# Your subnet ID is:
#
#     subnet-8e99c7ea
#
# Your security group ID is:
#
#     sg-578da130
#
# Your Identity is:
#
#     HashiDays-2017-tf-stingray
#

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  # ...
  ami           = "ami-f2b39792"
  instance_type = "t2.micro"
  subnet_id     = "subnet-8e99c7ea"
  count         = "2"

  vpc_security_group_ids = [
    "sg-578da130",
  ]

  tags {
    Identity = "HashiDays-2017-tf-stingray"
    Foo      = "bar"
    Zip      = "zap"
    Name     = "web ${count.index+1}/${var.num_webs}"
  }
}

terraform {
  backend "atlas" {
    name = "drgreene/training"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
