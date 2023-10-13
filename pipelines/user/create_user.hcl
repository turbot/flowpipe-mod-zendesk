// usage: flowpipe pipeline run create_user  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg new_user_email="abbc@turbot.com" --pipeline-arg new_user_name="abbc" --pipeline-arg new_user_role="end-user"

pipeline "create_user" {
  title       = "Create user"
  description = "Create a user."

  param "token" {
    type        = string
    description = "API tokens are auto-generated passwords in the Zendesk Admin Center."
    default     = var.token
  }

  param "user_email" {
    type        = string
    description = "The email ID of the user the account belongs to."
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = "The subdomain under which the account is created."
    default     = var.subdomain
  }

  param "new_user_email" {
    type        = string
    description = "The email ID of the user created."
  }

  param "new_user_name" {
    type        = string
    description = "The name of the user created."
  }

  param "new_user_role" {
    type        = string
    description = "The role of the user created."
    default     = "end-user"
  }

  // We do not know a valid custom role ID to pass through the params
  // param "new_user_custom_role_id" {
  //   type    = string
  //   default = "123456"
  // }

  step "http" "create_user" {
    title  = "Create user"
    method = "post"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
    request_body = jsonencode({
      user = {
        name  = param.new_user_name
        email = param.new_user_email
        role  = param.new_user_role
        // custom_role_id = param.new_user_custom_role_id
      }
    })
  }

  output "user" {
    description = "The user that has been created."
    value       = jsondecode(step.http.create_user.response_body).user
  }
}
