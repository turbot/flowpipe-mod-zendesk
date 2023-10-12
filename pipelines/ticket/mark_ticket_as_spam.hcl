// usage: flowpipe pipeline run mark_ticket_as_spam  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="13"

pipeline "mark_ticket_as_spam" {
  title       = "Mark a ticket as spam and suspend the user"
  description = "Mark the specified ticket as spam and suspend the user."

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
    description = "The ID of the ticket for which followers are to be listed."
  }

  step "http" "mark_ticket_as_spam" {
    title  = "Mark the specified ticket as spam and suspend the user"
    method = "put"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/mark_as_spam.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
  }

  output "status_code" {
    description = "HTTP response status code."
    value       = step.http.mark_ticket_as_spam.status_code
  }
}
