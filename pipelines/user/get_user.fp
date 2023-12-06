pipeline "get_user" {
  title       = "Get User"
  description = "Get user by a user ID."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
  }

  step "http" "get_user" {
    method = "get"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "user" {
    description = "Details of a particular user."
    value       = step.http.get_user.response_body.user
  }
}
