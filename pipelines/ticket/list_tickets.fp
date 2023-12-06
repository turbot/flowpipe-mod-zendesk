pipeline "list_tickets" {
  title       = "List Tickets"
  description = "List the tickets."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  step "http" "list_tickets" {
    method = "get"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets.json?page[size]=100"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }

    loop {
      until = result.response_body.meta.has_more == false
      url   = result.response_body.links.next
    }

  }

  output "tickets" {
    description = "List of tickets."
    value       = flatten([for page, tickets in step.http.list_tickets : tickets.response_body.tickets])
  }

}
