pipeline "get_ticket_comments_count" {
  title       = "Count Ticket Comments"
  description = "Count the number of ticket comments."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "ticket_id" {
    type        = string
    description = "The ID of the ticket."
  }

  step "http" "get_ticket_comments_count" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}/comments/count.json"

    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "ticket_comments_count" {
    description = "The number of ticket comments in an account."
    value       = step.http.get_ticket_comments_count.response_body.count.value
  }
}
