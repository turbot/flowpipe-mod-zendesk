pipeline "get_ticket_comments_count" {
  title       = "Count Ticket Comments"
  description = "Count the number of ticket comments."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "get_ticket_comments_count" {
    method = "get"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/comments/count.json"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "ticket_comments_count" {
    description = "The number of ticket comments in an account."
    value       = step.http.get_ticket_comments_count.response_body.count.value
  }
}
