resource "aws_cognito_user_pool" "demo-cognoti-user-pool" {
  name = "terraform-demo-cognito-user-pool"
}

resource "aws_cognito_user_pool_domain" "demo-cognito-identity-pool-domain" {
  domain       = "tf-domain-${random_uuid.demo-random.result}"
  user_pool_id = "${aws_cognito_user_pool.demo-cognoti-user-pool.id}"
}

# ##########

resource "aws_cognito_identity_pool" "demo-cognito-identity-pool" {
  identity_pool_name               = "terraform demo cognito identity pool"
  allow_unauthenticated_identities = true
  cognito_identity_providers {
    client_id               = "${random_string.demo-random-string.result}"
    provider_name           = "${aws_cognito_user_pool.demo-cognoti-user-pool.endpoint}"
    server_side_token_check = false
  }
}

# resource "aws_cognito_user_pool_client" "demo-cognito-user-pool-client" {
#   name = "terraformDemoCognitoUserPoolClient"
#   user_pool_id = "${var.cognito_user_pool_id}"
#   allowed_oauth_flows = ["code"]
#   allowed_oauth_scopes = ["phone", "email", "openid", "profile"]
#   callback_urls = ["https://${aws_elasticsearch_domain.demo-es-domain.kibana_endpoint}"]
#   logout_urls = ["https://${aws_elasticsearch_domain.demo-es-domain.kibana_endpoint}"]
# }