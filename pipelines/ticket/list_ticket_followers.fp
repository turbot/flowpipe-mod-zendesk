pipeline "list_ticket_followers" {
  title       = "List Ticket Followers"
  description = "List the followers of a ticket."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "list_ticket_followers" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/followers.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "ticket_followers" {
    description = "The list of followers of a ticket."
    value       = step.http.list_ticket_followers.response_body
  }
}
