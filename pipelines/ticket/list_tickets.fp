pipeline "list_tickets" {
  title       = "List Tickets"
  description = "List the tickets."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  step "http" "list_tickets" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets.json?page[size]=100"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
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
