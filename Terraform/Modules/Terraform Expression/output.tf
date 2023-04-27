output "iam_user_created_by_count_expression" {
  value = aws_iam_user.example[*].arn
}

output "iam_user_created_by_for_each_expression" {
  value = values(aws_iam_user.example_for_each)[*].arn
}