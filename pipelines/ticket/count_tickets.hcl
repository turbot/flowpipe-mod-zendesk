// usage: flowpipe pipeline run count_tickets  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport"

pipeline "count_tickets" {
  description = "Count the number of tickets in your account."

  param "zendesk_token" {
    type        = string
    description = "The Zendesk token for authorization"
    default     = var.zendesk_token
  }

  param "user_email" {
    type        = string
    description = "The user email ID of the user the account belongs to."
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = "The name of the subdomain under which the account is created."
    default     = var.subdomain
  }

  step "http" "count_tickets" {
    title  = "Count teh number of tickets in the account"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "tickets_count" {
    value = jsondecode(step.http.count_tickets.response_body).count.value
  }
  output "response_body" {
    value = step.http.count_tickets.response_body
  }
  output "response_headers" {
    value = step.http.count_tickets.response_headers
  }
  output "status_code" {
    value = step.http.count_tickets.status_code
  }
}
