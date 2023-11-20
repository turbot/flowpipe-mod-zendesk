# usage: flowpipe pipeline run update_user --pipeline-arg user_id="23902353045273" --pipeline-arg user_name="new-abcd" --pipeline-arg suspended_status="true" --pipeline-arg remote_photo_url="http://link.to/profile/image.png"
pipeline "update_user" {
  title       = "Update User"
  description = "Update a user."

  param "api_token" {
    type        = string
    description = local.api_token_param_description
    default     = var.api_token
  }

  param "user_email" {
    type        = string
    description = local.user_email_param_description
    default     = var.user_email
  }

  param "subdomain" {
    type        = string
    description = local.subdomain_param_description
    default     = var.subdomain
  }

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
    optional    = true
  }

  param "name" {
    type        = string
    description = "The updated name of the user."
    optional    = true
  }

  param "suspended_status" {
    type        = string
    description = "The updated state of the user whether suspended or not."
    optional    = true
  }

  param "remote_photo_url" {
    type        = string
    description = "The updated remote photo url of the user."
    optional    = true
  }

  step "http" "update_user" {
    method = "put"
    url    = "https://${param.subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${param.user_email}/token:${param.api_token}")}"
    }
    request_body = jsonencode({ user = { for name, value in param : name => value if value != null } })
  }

  output "user" {
    description = "The updated user details."
    value       = step.http.update_user.response_body.user
  }
}
