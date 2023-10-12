// usage: flowpipe pipeline run update_user  --execution-mode synchronous --pipeline-arg token="HBYYYYYGMuAGBuG9hipJTQQQQQVZwX5rRfwB0xuM" --pipeline-arg user_email="madhushree@turbot.com" --pipeline-arg subdomain="turbotsupport" --pipeline-arg user_id="23902353045273" --pipeline-arg new_user_name="new-abcd" --pipeline-arg new_suspended_status="true" --pipeline-arg remote_photo_url="http://link.to/profile/image.png"

pipeline "update_user" {
  title       = "Update user"
  description = "Update a user."

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

  param "new_user_name" {
    type        = string
    description = "The updated name of the user."
  }

  param "new_suspended_status" {
    type        = string
    description = "The updated state of the user whether suspended or not."
  }

  param "new_remote_photo_url" {
    type        = string
    description = "The updated remote photo url of the user."
  }

  step "http" "update_user" {
    title  = "Update user"
    method = "put"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.token}")}"
    }
    request_body = jsonencode({
      user = {
        name             = param.new_user_name
        suspended        = param.new_suspended_status
        remote_photo_url = param.new_remote_photo_url
      }
    })
  }

  output "user" {
    description = "The updated user."
    value       = jsondecode(step.http.update_user.response_body).user
  }
}
