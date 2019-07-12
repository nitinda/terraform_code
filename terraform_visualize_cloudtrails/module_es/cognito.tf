# resource "aws_cognito_identity_pool" "demo-cognito-identity-pool" {
#   identity_pool_name               = "terraform demo cognito identity pool"
#   allow_unauthenticated_identities = true
# #   cognito_identity_providers {
# #     client_id               = "${aws_cognito_user_pool_client.demo-cognito-user-pool-client.id}"
# #     provider_name           = "${var.cognito_user_pool_endpoint}"
# #     server_side_token_check = false
# #   }
# }

# resource "aws_cognito_identity_pool" "demo-cognito-identity-pool" {
#   identity_pool_name               = "terraform demo cognito identity pool"
#   allow_unauthenticated_identities = true
#   cognito_identity_providers {
#     client_id               = "${aws_cognito_user_pool_client.demo-cognito-user-pool-client.id}"
#     provider_name           = "${var.cognito_user_pool_endpoint}"
#     server_side_token_check = true
#   }
# }

# resource "aws_cognito_user_pool_client" "demo-cognito-user-pool-client" {
#   name = "terraformDemoCognitoUserPoolClient"
#   user_pool_id = "${var.cognito_user_pool_id}"
#   supported_identity_providers = ["COGNITO"]
#   allowed_oauth_flows_user_pool_client = true
#   allowed_oauth_flows = ["code"]
#   allowed_oauth_scopes = ["phone", "email", "openid", "profile"]
#   callback_urls = ["https://${aws_elasticsearch_domain.demo-es-domain.kibana_endpoint}"]
#   logout_urls = ["https://${aws_elasticsearch_domain.demo-es-domain.kibana_endpoint}"]
# }

# resource "aws_cognito_identity_provider" "demo-cognito-identity-provider" {
#   user_pool_id  = "${aws_cognito_identity_pool.demo-cognito-identity-pool.id}"
#   provider_name = "${var.cognito_user_pool_id}"
#   provider_type = "OIDC"

#   provider_details = {
#     authorize_scopes = "email"
#     client_id        = "your client_id"
#     client_secret    = "your client_secret"
#   }

#   attribute_mapping = {
#     email    = "email"
#     username = "sub"
#   }
# }