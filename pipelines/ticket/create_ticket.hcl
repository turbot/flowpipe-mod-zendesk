// usage: flowpipe pipeline run create_ticket  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_subject="test-ticket-for-test" --pipeline-arg ticket_body="Demo ticket body"

pipeline "create_ticket" {
  description = "Create a ticket."

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

  param "ticket_subject" {
    type        = string
    description = "The subject of the ticket that is to be created."
  }

  param "ticket_body" {
    type        = string
    description = "The body of the ticket that is to be created."
  }

  step "http" "create_ticket" {
    title  = "Create a user"
    method = "post"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
    request_body = jsonencode({
      ticket = {
        subject = param.ticket_subject
        comment = {
          body = param.ticket_body
        }
      }
    })
  }

  output "tickets_subject" {
    value = jsondecode(step.http.list_tickets.response_body).tickets[*].subject
  }
  output "response_body" {
    value = step.http.create_ticket.response_body
  }
  output "response_headers" {
    value = step.http.create_ticket.response_headers
  }
  output "status_code" {
    value = step.http.create_ticket.status_code
  }
}
