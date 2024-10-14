pipeline "get_user" {
  title       = "Get User"
  description = "Get user by user ID."

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
  }

  step "http" "get_user" {
    method = "get"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "user" {
    description = "Details of a particular user."
    value       = step.http.get_user.response_body.user
  }
}
