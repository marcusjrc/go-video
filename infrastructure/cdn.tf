
resource "aws_cloudfront_distribution" "app_distribution" {
    enabled             = true
    is_ipv6_enabled     = true
    aliases = [var.domain]

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }
    price_class = "PriceClass_All"
    viewer_certificate {
        acm_certificate_arn = "${aws_acm_certificate_validation.cert_validation.certificate_arn}"
        ssl_support_method = "sni-only"
    }

    origin {
        custom_origin_config {
            http_port = 80
            https_port = 443
            origin_protocol_policy = "https-only"
            origin_ssl_protocols = ["TLSv1.2"]
        }
        domain_name = "${aws_lb.backend_alb.dns_name}"
        origin_id   = "backend-alb"
    }

    ordered_cache_behavior {
        path_pattern = "*"
        allowed_methods  = ["GET", "HEAD", "OPTIONS", "POST", "PUT", "DELETE", "PATCH"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "backend-alb"
        viewer_protocol_policy = "redirect-to-https"
        forwarded_values {
            query_string = true
            headers = ["*"]
            cookies {
                forward = "all"
            }
        }
    }


    default_cache_behavior {
        allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "backend-alb"
        compress = true
        viewer_protocol_policy = "redirect-to-https"

        forwarded_values {
            query_string = true
            cookies {
                forward = "all"
            }
        }
        min_ttl                = 0
        default_ttl            = 0
        max_ttl                = 0
    }

    tags = {
        Environment = var.environment
    }

}