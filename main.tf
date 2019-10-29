provider "aws" {
  version = "~> 2.0"
  region  = "${var.region}"
}

# Certificate
resource "aws_acm_certificate" "certificate" {
  domain_name               = "${var.domain_name}"
  
  validation_method         = "DNS"

  subject_alternative_names = "${var.subject_alternative_names}"

  lifecycle {
    create_before_destroy   = true
  }

  tags                      = "${var.tags}"

}

# Domain for certificate verification
resource "aws_route53_record" "validation" {
  count     = "${length(var.subject_alternative_names) + 1}"
  name      = "${lookup(element(aws_acm_certificate.certificate.domain_validation_options, count.index), "resource_record_name")}"
  type      = "${lookup(element(aws_acm_certificate.certificate.domain_validation_options, count.index), "resource_record_type")}"
  zone_id   = "${var.zone_id}"
  records   = ["${lookup(element(aws_acm_certificate.certificate.domain_validation_options, count.index), "resource_record_value")}"]
  ttl       = 60
}

# Validation
resource "aws_acm_certificate_validation" "validation" {
  certificate_arn         = "${aws_acm_certificate.certificate.arn}"
  validation_record_fqdns = "${aws_route53_record.validation.*.fqdn}"
  depends_on = ["aws_acm_certificate.certificate", "aws_route53_record.validation"]
}
