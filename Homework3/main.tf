provider aws {
	region = "us-west-2"
}

resource "aws_key_pair" "deployeraz" {
  key_name   = "Bastion-key"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_instance" "web" {
  ami           = "ami-07c5ecd8498c59db5"
  instance_type = "t2.micro"
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  key_name = aws_key_pair.deployeraz.key_name
  vpc_security_group_ids = [aws_security_group.anna.id]
  user_data = file("apache.sh")
  count = 3

  tags = {
    Name = "web-${count.index+1}"
  }
}

data "aws_availability_zones" "available" {}

output ec2 {
    value = aws_instance.web[0].public_ip
}

# element(var.zones, count.index)

# "ami-07c5ecd8498c59db5"

# default = ["us-west-2a", "us-west-2b", "us-west-2c"]

# data.aws_ami.amazon-linux-2.ids