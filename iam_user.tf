resource "aws_iam_user" "cypha" {
  name = "lord_cypha"
  path = "/system/"

  tags = {
    tag-key = "rand"
  }
}