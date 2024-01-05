resource "aws_s3_bucket" "example" {
  bucket = "mychail-jordan-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}