resource "aws_s3_bucket" "posseidon-bucket" {
  bucket = "lord-posseidon-bucket"

  tags = {
    Name        = "possidon s3 bucket"
    Environment = "Dev"
  }
}