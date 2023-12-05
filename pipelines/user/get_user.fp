pipeline "get_user" {
  title       = "Get User"
  description = "Get user by a user ID."

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

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
  }

  step "http" "get_user" {
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "user" {
    description = "Details of a particular user."
    value       = step.http.get_user.response_body.user
  }
}
