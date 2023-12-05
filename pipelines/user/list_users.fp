pipeline "list_users" {
  title       = "List Users"
  description = "List the Zendesk users."

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

  step "http" "list_users" {
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users.json?page[size]=100"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }

    loop {
      until = result.response_body.meta.has_more == false
      url   = result.response_body.links.next
    }
  }

  output "users" {
    description = "The list of users associated to the account."
    value       = flatten([for page, users in step.http.list_users : users.response_body.users])
  }
}
