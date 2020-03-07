resource "aws_elb" "eis-data" {
    name = "eis-data-elb"
    security_groups = ["${aws_security_group.load_balancers.id}"]
    subnets = ["${aws_subnet.main.id}"]

    listener {
        lb_protocol = "http"
        lb_port = 80

        instance_protocol = "http"
        instance_port = 8080
    }

    health_check {
        healthy_threshold = 3
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:8080/c3api_data/v2/DataAccess.svc"
        interval = 15
    }

    cross_zone_load_balancing = true
}

resource "aws_ecs_task_definition" "eis-data" {
    family = "eis-data"
    container_definitions = "${file("task-definitions/eis-data.json")}"
}

resource "aws_ecs_service" "eis-data" {
    name = "eis-data"
    cluster = "${aws_ecs_cluster.main.id}"
    task_definition = "${aws_ecs_task_definition.eis-data.arn}"
    iam_role = "${aws_iam_role.ecs_service_role.arn}"
    desired_count = 1
    depends_on = ["aws_iam_role_policy.ecs_service_role_policy"]

    load_balancer {
        elb_name = "${aws_elb.eis-data.id}"
        container_name = "eis-data"
        container_port = 8080
    }
}

output "endpoint" {
  value       = "http://${aws_elb.eis-data.dns_name}/c3api_data/v2/DataAccess.svc"
  description = "Service root of API"
}