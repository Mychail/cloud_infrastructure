resource "aws_iam_user" "cypha-airflow" {
  name = "cypha-airflow-user"
  path = "/system/"

  tags = {
    tag-key = "rand-airflow"
  }
}


resource "aws_iam_policy" "airflow-policy" {
  name        = "airflow-policy-cypha"
  path        = "/"
  description = "my training policy sample"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:*Object*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}


resource "aws_iam_policy_attachment" "airflow-attach" {
  name       = "cypha-airflow-attachment"
  users      = [aws_iam_user.cypha-airflow.name]
  policy_arn = aws_iam_policy.airflow-policy.arn
}

resource "aws_iam_access_key" "airflow-accesskey" {
  user = aws_iam_user.cypha-airflow.name
}

resource "aws_ssm_parameter" "airflow-access-key" {
  name  = "/cypha-airflow/access-key"
  type  = "String"
  value = "aws_iam_access_key.airflow-accesskey.id"
}

resource "aws_ssm_parameter" "airflow-secret-key" {
  name  = "/cypha-airflow/secret-access-key"
  type  = "String"
  value = "aws_iam_access_key.airflow-accesskey.secret"
}