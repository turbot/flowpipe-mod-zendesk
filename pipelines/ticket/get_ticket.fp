pipeline "get_ticket" {
  title       = "Get Ticket"
  description = "Get a ticket by ticket ID."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "get_ticket" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "ticket" {
    description = "Details of a particular ticket."
    value       = step.http.get_ticket.response_body.ticket
  }
}
