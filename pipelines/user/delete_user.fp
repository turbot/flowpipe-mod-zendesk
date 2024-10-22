pipeline "delete_user" {
  title       = "Delete User"
  description = "Delete a user."

  tags = {
    recommended = "true"
  }

  param "conn" {
    type        = connection.zendesk
    description = local.conn_param_description
    default     = connection.zendesk.default
  }

  param "user_id" {
    type        = string
    description = "The user ID of the user to be deleted."
  }

  step "http" "delete_user" {
    method = "delete"
    url    = "https://${param.conn.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.conn.email}/token:${param.conn.token}")}"
    }
  }

  output "user" {
    description = "The deleted user details."
    value       = step.http.delete_user.response_body.user
  }
}
