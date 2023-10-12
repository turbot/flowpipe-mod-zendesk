// usage: flowpipe pipeline run update_ticket_comment  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg ticket_id="15" --pipeline-arg new_body="This is the last updated body of the ticket" --pipeline-arg comment_is_public="true"

pipeline "update_ticket_comment" {
  title       = "Update the comment for a particular ticket"
  description = "Update the comment for a particular ticket."

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

  param "comment_is_public" {
    type        = string
    description = "The updated body of the ticket."
  }

  step "http" "update_ticket_comment" {
    title  = "Update the comment for a particular ticket"
    method = "put"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/tickets/${param.ticket_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
    request_body = jsonencode({
      ticket = {
        comment = {
          body   = param.new_body
          public = param.comment_is_public
        }
      }
    })
  }

  output "ticket_comments" {
    description = "Updated ticket comment."
    value       = jsondecode(step.http.update_ticket_comment.response_body).ticket.comment
  }
}
