provider "aws" {
  region = "us-east-1" 
}


resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0" 
  instance_type = "t2.micro" 
  key_name      = "your-key-pair-name" 

  tags = {
    Name = "example-instance"
  }
}

# Create a launch configuration
resource "aws_launch_configuration" "example" {
  name_prefix          = "example"
  image_id             = "ami-0c55b159cbfafe1f0"
  instance_type        = "t2.micro"
  security_groups      = ["sg-0123456789abcdef0"] 
  key_name             = "your-key-pair-name" 
  iam_instance_profile = "your-iam-profile-name" 

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World!" > index.html
              nohup python -m SimpleHTTPServer 80 &
              EOF
}

# Create an Auto Scaling group
resource "aws_autoscaling_group" "example" {
  name_prefix                 = "example"
  launch_configuration        = aws_launch_configuration.example.name
  min_size                    = 2
  max_size                    = 5
  desired_capacity            = 2
  vpc_zone_identifier         = ["subnet-0123456789abcdef0"] 
  health_check_grace_period   = 300
  termination_policies        = ["OldestLaunchConfiguration"]
}


resource "aws_autoscaling_policy" "example" {
  name                   = "example-policy"
  autoscaling_group_name  = aws_autoscaling_group.example.name
  adjustment_type        = "ChangeInCapacity"
  scaling_adjustment     = 1
  cooldown               = 300
}



resource "aws_launch_configuration" "Cnfig" {
    name_prefix          = "TP.C"
    image_id             = "ami-0c55b159cbfafe1f0"
    instance_type        = "t2.micro"

}
