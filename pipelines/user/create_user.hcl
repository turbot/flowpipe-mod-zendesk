# usage: flowpipe pipeline run create_user --pipeline-arg email="test001@example.com" --pipeline-arg name="test001" --pipeline-arg role="end-user"
pipeline "create_user" {
  title       = "Create User"
  description = "Create a user."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "user_email" {
    type        = string
    description = local.user_email_param_description
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = local.subdomain_param_description
    default     = var.subdomain
  }

  param "email" {
    type        = string
    description = "The email ID of the user created."
  }

  param "name" {
    type        = string
    description = "The name of the user created."
  }

  param "role" {
    type        = string
    description = "The role of the user created."
    default     = "end-user"
  }

  // We do not know a valid custom role ID to pass through the params
  // param "user_custom_role_id" {
  //   type    = string
  //   default = "123456"
  // }

  step "http" "create_user" {
    method = "post"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
    request_body = jsonencode({ user = { for name, value in param : name => value if value != null } })
  }

  output "user" {
    description = "The user that has been created."
    value       = step.http.create_user.response_body.user
  }
}
