// usage: flowpipe pipeline run delete_user  --execution-mode synchronous --pipeline-arg zendesk_token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg user_id="23902353108889"

pipeline "delete_user" {
  description = "Delete a user."

  param "zendesk_token" {
    type        = string
    description = "The Zendesk token for authorization"
    default     = var.zendesk_token
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

  param "user_id" {
    type        = string
    description = "The user ID of the user to be deleted."
  }

  step "http" "delete_user" {
    title  = "Delete a user"
    method = "delete"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.zendesk_token}")}"
    }
  }

  output "users" {
    value = jsondecode(step.http.search_users.response_body).users
  }
  output "response_body" {
    value = step.http.delete_user.response_body
  }
  output "response_headers" {
    value = step.http.delete_user.response_headers
  }
  output "status_code" {
    value = step.http.delete_user.status_code
  }
}
