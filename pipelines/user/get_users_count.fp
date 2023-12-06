pipeline "get_users_count" {
  title       = "Count Users"
  description = "Count the number of users."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  step "http" "get_users_count" {
    method = "get"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/users/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "users_count" {
    description = "The number of users associated to the account."
    value       = step.http.get_users_count.response_body.count.value
  }
}
