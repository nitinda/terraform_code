output "cognito_user_pool_id" {
  value = "${aws_cognito_user_pool.demo-cognoti-user-pool.id}"
}

output "cognito_identity_pool_id" {
  value = "${aws_cognito_identity_pool.demo-cognito-identity-pool.id}"
}

output "cognito_user_pool_endpoint" {
  value = "${aws_cognito_user_pool.demo-cognoti-user-pool.endpoint}"
}

output "cognito_iam_role_arn" {
  value = "${aws_iam_role.demo-iam-role-cognito.arn}"
}
