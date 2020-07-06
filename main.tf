provider "aws" {
  region                  = "ap-northeast-1"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "default"
}

resource "aws_iam_user" "serverless" {
  name = "flask-blog-dynamodb"
  path = "/"
}

resource "aws_iam_access_key" "access_key" {
  user = "${aws_iam_user.serverless.name}"
}

resource "aws_iam_access_key" "zappa_access_key" {
  user = "${aws_iam_user.zappa.name}"
}

resource "aws_iam_policy_attachment" "attach" {
  name       = "attachment"
  users      = ["${aws_iam_user.serverless.name}"]
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_iam_policy_attachment" "zappa-attach" {
  name       = "zappa-attachment"
  users      = ["${aws_iam_user.zappa.name}"]
  policy_arn = "${aws_iam_policy.serverless.arn}"
}

resource "aws_iam_group" "serverless" {
  name = "flask_blog_group"
  path = "/users/"
}

resource "aws_iam_user" "zappa" {
  name = "zappa"
  path = "/"
}

resource "aws_iam_policy" "serverless" {
  name  = "flask_blog"

  policy = <<EOF
{
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": [
                    "iam:AttachRolePolicy",
                    "iam:CreateRole",
                    "iam:GetRole",
                    "iam:PutRolePolicy"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "iam:PassRole"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "apigateway:DELETE",
                    "apigateway:GET",
                    "apigateway:PATCH",
                    "apigateway:POST",
                    "apigateway:PUT",
                    "events:DeleteRule",
                    "events:DescribeRule",
                    "events:ListRules",
                    "events:ListTargetsByRule",
                    "events:ListRuleNamesByTarget",
                    "events:PutRule",
                    "events:PutTargets",
                    "events:RemoveTargets",
                    "lambda:AddPermission",
                    "lambda:CreateFunction",
                    "lambda:DeleteFunction",
                    "lambda:GetFunction",
                    "lambda:GetFunctionConfigration",
                    "lambda:GetPolicy",
                    "lambda:ListVersionsByFunction",
                    "lambda:RemovePermission",
                    "lambda:UpdateFunctionCode",
                    "lambda:UpdateFunctionConfigration",
                    "cloudformation:CreateStack",
                    "cloudformation:DeleteStack",
                    "cloudformation:DescribeStackResource",
                    "cloudformation:DescribeStacks",
                    "cloudformation:ListStackResources",
                    "cloudformation:UpdateStack",
                    "cloudfornt:updateDistribution",
                    "logs:DescribeLogStreams",
                    "logs:FilterLogEvents",
                    "route53:ListHostedZones",
                    "route53:ChangeResourceRecordSets",
                    "route53:GetHostedZone",
                    "s3:CreateBucket",
                    "dynamodb:*"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:ListBucket"
                ],
                "Resource": ["*"]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "s3:DeleteObject",
                    "s3:GetObject",
                    "s3:PutObject",
                    "s3:CreateMultipartUpload",
                    "s3:AbortMultipartUpload",
                    "s3:ListMultipartUploadParts",
                    "s3:ListBucketMultipartUploads"
                ],
                "Resource": ["*"]
            }
        ]
    }
EOF
}

output "secret" {
  value = "${aws_iam_access_key.access_key.secret}"
}

output "id" {
  value = "${aws_iam_access_key.access_key.id}"
}

output "user" {
  value = "${aws_iam_access_key.access_key.user}"
}

output "zappa_secret" {
  value = "${aws_iam_access_key.zappa_access_key.secret}"
}

output "zapp_id" {
  value = "${aws_iam_access_key.zappa_access_key.id}"
}
