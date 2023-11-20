# usage: flowpipe pipeline run list_tickets
pipeline "list_tickets" {
  title       = "List Tickets"
  description = "List the tickets."

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

  step "http" "list_tickets" {
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
  }

  output "tickets" {
    description = "The list of all tickets in the account."
    value       = step.http.list_tickets.response_body.tickets
  }

  output "tickets_count" {
    description = "The number of tickets in the account."
    value       = step.http.list_tickets.response_body.count
  }
}
