resource "aws_s3_bucket" "demo_bucket" {
  bucket = "${var.project_name}-bucket"
}