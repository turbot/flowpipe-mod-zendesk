// usage: flowpipe pipeline run get_user --pipeline-arg user_id="23953683763865"

pipeline "get_user" {
  title       = "Get User"
  description = "Get user by a user ID."

  param "api_token" {
    type        = string
    description = "API tokens are auto-generated passwords in the Zendesk Admin Center."
    default     = var.api_token
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

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
  }

  step "http" "get_user" {
    title  = "Get User"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "user" {
    description = "Details of a particular user."
    value       = jsondecode(step.http.get_user.response_body).user
  }
}
