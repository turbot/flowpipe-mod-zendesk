pipeline "get_tickets_count" {
  title       = "Count Tickets"
  description = "Count the number of tickets."

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

  step "http" "get_tickets_count" {
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "tickets_count" {
    description = "The number of tickets in the account."
    value       = step.http.get_tickets_count.response_body
  }
}
