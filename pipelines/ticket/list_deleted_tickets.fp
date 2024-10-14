pipeline "list_deleted_tickets" {
  title       = "List Deleted Tickets"
  description = "List the deleted tickets."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  step "http" "list_deleted_tickets" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/deleted_tickets.json?page[size]=100"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }

    loop {
      until = result.response_body.meta.has_more == false
      url   = result.response_body.links.next
    }
  }

  output "deleted_tickets" {
    description = "The list of users associated to the account."
    value       = flatten([for page, tickets in step.http.list_deleted_tickets : tickets.response_body.deleted_tickets])
  }
}
