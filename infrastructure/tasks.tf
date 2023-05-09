resource "aws_cloudwatch_log_group" "backend-log-group" {
  name_prefix       = "${var.environment}-backend"
  retention_in_days = 30
}

resource "aws_cloudwatch_log_group" "nginx-log-group" {
  name_prefix       = "${var.environment}-nginx"
  retention_in_days = 30
}

resource "aws_ecs_task_definition" "backend" {
  family = "backend"
  container_definitions = <<EOF
[{
		"name": "backend",
		"image": "${aws_ecr_repository.govideo.repository_url}:govideo",
		"cpu": 512,
		"memoryReservation": 200,
		"essential": true,
		"environment": [{
				"name": "DOMAIN",
				"value": "${var.domain}"
			},
			{
				"name": "REGION",
				"value": "${var.region}"
			},
			{
				"name": "DB_PASSWORD",
				"value": "${var.db_password}"
			},
			{
				"name": "DB_HOST",
				"value": "${module.db.db_instance_address}"
			},
			{
				"name": "DB_USERNAME",
				"value": "${module.db.db_instance_username}"
			},
			{
				"name": "DB_NAME",
				"value": "${module.db.db_instance_name}"
			}
		],
		"portMappings": [{
			"containerPort": 8080,
			"hostPort": 8080
		}],
		"logConfiguration": {
			"logDriver": "awslogs",
			"options": {
				"awslogs-region": "${var.region}",
				"awslogs-group": "${aws_cloudwatch_log_group.backend-log-group.name}",
				"awslogs-stream-prefix": "ec2"
			}
		}
	},
	{
		"name": "nginx-reverse-proxy",
		"image": "${aws_ecr_repository.nginx-reverse-proxy.repository_url}:latest",
		"memoryReservation": 128,
		"cpu": 1024,
		"essential": true,
		"logConfiguration": {
			"logDriver": "awslogs",
			"options": {
				"awslogs-region": "${var.region}",
				"awslogs-group": "${aws_cloudwatch_log_group.nginx-log-group.name}",
				"awslogs-stream-prefix": "ec2"
			}
		},
		"links": [
			"backend"
		],
		"portMappings": [{
			"containerPort": 80,
			"hostPort": 80
		}]
	}
]
EOF
}

resource "aws_ecs_service" "backend_service" {
  name            = "backend-service"
  cluster         = module.ecs.cluster_id
  task_definition = aws_ecs_task_definition.backend.arn

  desired_count = 1

  deployment_maximum_percent         = 100
  deployment_minimum_healthy_percent = 0
  force_new_deployment = true

  load_balancer {
    target_group_arn = aws_lb_target_group.backend_alb_target.arn
    container_name   = "nginx-reverse-proxy"
    container_port   = 80
  }
}





