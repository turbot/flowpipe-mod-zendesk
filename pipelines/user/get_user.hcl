// usage: flowpipe pipeline run get_user  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg user_id="23953683763865"

pipeline "get_user" {
  title       = "Get details of a user"
  description = "Get details of a user."

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

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
  }

  step "http" "get_user" {
    title  = "Get details of a user"
    method = "get"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
  }

  output "status_code" {
    description = "Details of a particular user."
    value       = step.http.get_user.status_code
  }
}
