pipeline "delete_user" {
  title       = "Delete User"
  description = "Delete a user."

  tags = {
    type = "featured"
  }
  
  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = "The user ID of the user to be deleted."
  }

  step "http" "delete_user" {
    title  = "Delete User"
    method = "delete"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "user" {
    description = "The deleted user details."
    value       = step.http.delete_user.response_body.user
  }
}
