resource "aws_ecs_cluster" "main" {
  name = "assignment-cluster"
}

resource "aws_security_group" "ecs_sg" {
  name   = "ecs-security-group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#resource "aws_iam_role" "ecs_task_execution_role" {
 # name = "ecsTaskExecutionRole"

  #assume_role_policy = jsonencode({
   # Version = "2012-10-17"
   # Statement = [
     # {
       # Action = "sts:AssumeRole"
      #  Effect = "Allow"
    ##    Principal = {
     #     Service = "ecs-tasks.amazonaws.com"
    #    }
   #   }
  #  ]
 # })
#}

#resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
 # role       = aws_iam_role.ecs_task_execution_role.name
 # policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
#}

resource "aws_ecs_task_definition" "flask_task" {
  family                   = "flask-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = "arn:aws:iam::880690593684:role/ecsTaskExecutionRole"

  container_definitions = file("task-definitions/flask-task.json")
}

resource "aws_ecs_task_definition" "express_task" {
  family                   = "express-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "256"
  memory                   = "512"
  execution_role_arn = "arn:aws:iam::880690593684:role/ecsTaskExecutionRole"

  container_definitions = file("task-definitions/express-task.json")
}
resource "aws_ecs_service" "flask_service" {
  name            = "flask-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.flask_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_1.id, aws_subnet.public_2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

#  load_balancer {
 #   target_group_arn = aws_lb_target_group.flask_tg.arn
  #  container_name   = "flask-container"
   # container_port   = 5000
  #}

  depends_on = [aws_lb_listener.listener]
}

resource "aws_ecs_service" "express_service" {
  name            = "express-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.express_task.arn
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = [aws_subnet.public_1.id, aws_subnet.public_2.id]
    security_groups  = [aws_security_group.ecs_sg.id]
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.express_tg.arn
    container_name   = "express-container"
    container_port   = 3000
  }

  depends_on = [aws_lb_listener.listener]
}
