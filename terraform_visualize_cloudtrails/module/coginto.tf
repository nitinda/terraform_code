resource "aws_cognito_user_pool" "demo-cognoti-user-pool" {
  name = "terraform-demo-cognito-user-pool"
}

resource "aws_cognito_identity_pool" "demo-cognito-identity-pool" {
  identity_pool_name               = "terraform demo cognito identity pool"
  allow_unauthenticated_identities = true
}

resource "aws_cognito_user_pool_domain" "demo-cognito-identity-pool-domain" {
  domain       = "tf-domain-${random_uuid.demo-random.result}"
  user_pool_id = "${aws_cognito_user_pool.demo-cognoti-user-pool.id}"
}