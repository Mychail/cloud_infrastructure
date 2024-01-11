resource "aws_iam_policy" "data_eng_full_access_policy" {
  name        = "data_eng_full_access_policy"
  description = "Policy for full access to data engineering resources"

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = [
      {
        Action    = [
          "iam:*",
          "organizations:Describe*",
          "organizations:List*",
          "s3:*",
          "s3-object-lambda:*",
          "cloudwatch:PutMetricData",
          "ds:*",
          "ec2:DescribeInstanceStatus",
          "logs:*",
          "ec2messages:*",
          "ssm:*",
          "ssmmessages:Open*",
          "ssmmessages:Create*",
          "glue:*Database*",
          "glue:*Get*"
        ]
        Effect    = "Allow"
        Resource  = "*"
      }
    ]
  })
}


resource "aws_iam_group_policy_attachment" "data_eng_full_access_attachment" {
  group      = "data_engineering_hub"
  policy_arn = aws_iam_policy.data_eng_full_access_policy.arn
}
