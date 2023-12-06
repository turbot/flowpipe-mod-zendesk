pipeline "get_tickets_count" {
  title       = "Count Tickets"
  description = "Count the number of tickets."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  step "http" "get_tickets_count" {
    method = "get"
    url = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets/count.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
  }

  output "tickets_count" {
    description = "The number of tickets in the account."
    value       = step.http.get_tickets_count.response_body
  }
}
