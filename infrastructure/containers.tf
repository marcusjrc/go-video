
resource "aws_ecr_repository" "govideo" {
    name  = "govideo"
}

resource "aws_ecr_repository" "nginx-reverse-proxy" {
    name  = "nginx-reverse-proxy"
}