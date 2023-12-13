pipeline "update_user" {
  title       = "Update User"
  description = "Update a user."

  param "cred" {
    type        = string
    description = local.cred_param_description
    default     = "default"
  }

  param "user_id" {
    type        = string
    description = "The user ID of the user that is being displayed."
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
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/users/${param.user_id}.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
    request_body = jsonencode({ user = { for name, value in param : name => value if value != null } })
  }

  output "user" {
    description = "The updated user details."
    value       = step.http.update_user.response_body.user
  }
}
