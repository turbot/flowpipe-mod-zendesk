// usage: flowpipe pipeline run count_tickets

pipeline "count_tickets" {
  title       = "Count Tickets"
  description = "Count the number of tickets."

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

  step "http" "count_tickets" {
    title  = "Count Tickets"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "tickets_count" {
    description = "The number of tickets in an account."
    value       = jsondecode(step.http.count_tickets.response_body).count.value
  }
}
