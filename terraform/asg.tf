resource "aws_autoscaling_group" "ecs_asg" {
  name_prefix          = "ECS_ASG"
  vpc_zone_identifier  = [aws_subnet.pubsub.id, aws_subnet.privsub.id]
  desired_capacity     = 2
  max_size             = 3
  min_size             = 1
  health_check_type    = "EC2"
  termination_policies = ["OldestInstance"]

  launch_template {
    id      = aws_launch_template.ecs_lt.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}
