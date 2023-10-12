// usage: flowpipe pipeline run get_ticket  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="3"

pipeline "get_ticket" {
  description = "Get details of a ticket in your account."

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

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket to fetch details of."
    default     = ""
  }

  step "http" "show_ticket" {
    title  = "Get details of a ticket in your account"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "ticket" {
    value = jsondecode(step.http.show_ticket.response_body).ticket
  }
  output "ticket_id" {
    value = jsondecode(step.http.show_ticket.response_body).ticket.id
  }
  output "ticket_status" {
    value = jsondecode(step.http.show_ticket.response_body).ticket.status
  }
  output "ticket_subject" {
    value = jsondecode(step.http.show_ticket.response_body).ticket.subject
  }
  output "response_body" {
    value = step.http.show_ticket.response_body
  }
  output "response_headers" {
    value = step.http.show_ticket.response_headers
  }
  output "status_code" {
    value = step.http.show_ticket.status_code
  }
}
