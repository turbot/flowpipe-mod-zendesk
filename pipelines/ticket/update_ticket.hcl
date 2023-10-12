// usage: flowpipe pipeline run update_ticket  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="15" --pipeline-arg new_subject="This is the last new subject of the ticket" --pipeline-arg new_body="This is the last updated body of the ticket" --pipeline-arg new_status="solved"

pipeline "update_ticket" {
  title       = "Update ticket"
  description = "Update a ticket."

  param "token" {
    type        = string
    description = "The API token for authorization."
    default     = var.token
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
    description = "The ID of the ticket to update."
  }

  param "new_body" {
    type        = string
    description = "The updated body of the ticket."
  }

  param "new_subject" {
    type        = string
    description = "The updated subject of the ticket."
  }

  param "new_status" {
    type        = string
    description = "The updated status of the ticket."
  }

  step "http" "update_ticket" {
    title  = "Update ticket"
    method = "put"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
    request_body = jsonencode({
      ticket = {
        status  = param.new_status
        subject = param.new_subject
      }
    })
  }

  output "ticket" {
    description = "The updated ticket."
    value       = jsondecode(step.http.update_ticket.response_body).ticket
  }
}
