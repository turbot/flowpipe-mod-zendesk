pipeline "create_ticket" {
  title       = "Create Ticket"
  description = "Create a ticket."

  param "cred" {
    type        = string
    description = "Name for credentials to use. If not provided, the default credentials will be used."
    default     = "default"
  }

  param "comment" {
    type = object({
      body      = string
      public    = bool
      author_id = number
    })
    description = "An object that defines the properties of the ticket comment."
  }

  param "allow_attachments" {
    type        = bool
    description = "Permission for agents to add attachments to a comment. Defaults to true."
    optional    = true
  }

  param "allow_channelback" {
    type        = bool
    description = "Is false if channelback is disabled, true otherwise. Only applicable for channels framework ticket."
    optional    = true
  }

  param "assignee_email" {
    type        = string
    description = "Write only. The email address of the agent to assign the ticket to."
    optional    = true
  }

  param "assignee_id" {
    type        = number
    description = "The agent currently assigned to the ticket."
    optional    = true
  }

  param "attribute_value_ids" {
    type        = list(number)
    description = "Write only. An array of the IDs of attribute values to be associated with the ticket."
    optional    = true
  }

  param "brand_id" {
    type        = number
    description = "Enterprise only. The ID of the brand this ticket is associated with."
    optional    = true
  }

  param "collaborator_ids" {
    type        = list(number)
    description = "The IDs of users currently CC'ed on the ticket."
    optional    = true
  }

  param "collaborators" {
    type = list(object({
      name  = string
      email = string
    }))
    description = "POST requests only. Users to add as CC's when creating a ticket. See Setting Collaborators."
    optional    = true
  }

  param "created_at" {
    type        = string
    description = "When this record was created."
    optional    = true
  }

  param "custom_fields" {
    type = list(object({
      id    = number
      value = string
    }))
    description = "Custom fields for the ticket. See Setting custom field values."
    optional    = true
  }

  param "custom_status_id" {
    type        = number
    description = "The custom ticket status ID of the ticket. See custom ticket statuses."
    optional    = true
  }

  param "description" {
    type        = string
    description = "Read-only first comment on the ticket. When creating a ticket, use comment to set the description. See Description and first comment."
    optional    = true
  }

  param "due_at" {
    type        = string
    description = "If this is a ticket of type 'task', it has a due date. Due date format uses ISO 8601 format."
    optional    = true
  }

  param "email_cc_ids" {
    type        = list(number)
    description = "The IDs of agents or end users currently CC'ed on the ticket. See CCs and followers resources in the Support Help Center."
    optional    = true
  }

  param "email_ccs" {
    type = list(object({
      user_id = number
      email   = string
    }))
    description = "Write only. An array of objects that represent agent or end users email CCs to add or delete from the ticket. See Setting email CCs."
    optional    = true
  }

  param "external_id" {
    type        = string
    description = "An ID you can use to link Zendesk Support tickets to local records."
    optional    = true
  }

  param "follower_ids" {
    type        = list(number)
    description = "The IDs of agents currently following the ticket. See CCs and followers resources."
    optional    = true
  }

  param "followers" {
    type = list(object({
      user_id = number
    }))
    description = "Write only. An array of objects that represent agent followers to add or delete from the ticket. See Setting followers."
    optional    = true
  }

  param "followup_ids" {
    type        = list(number)
    description = "The IDs of the followups created from this ticket. IDs are only visible once the ticket is closed."
    optional    = true
  }

  param "forum_topic_id" {
    type        = number
    description = "The topic in the Zendesk Web portal this ticket originated from, if any. The Web portal is deprecated."
    optional    = true
  }

  param "from_messaging_channel" {
    type        = bool
    description = "If true, the ticket's via type is a messaging channel."
    optional    = true
  }

  param "group_id" {
    type        = number
    description = "The group this ticket is assigned to."
    optional    = true
  }

  param "has_incidents" {
    type        = bool
    description = "Is true if a ticket is a problem type and has one or more incidents linked to it. Otherwise, the value is false."
    optional    = true
  }

  param "ticket_id" {
    type        = number
    description = "Automatically assigned when the ticket is created."
    optional    = true
  }

  param "is_public" {
    type        = bool
    description = "Is true if any comments are public, false otherwise."
    optional    = true
  }

  param "macro_id" {
    type        = number
    description = "Write only. A macro ID to be recorded in the ticket audit."
    optional    = true
  }

  param "macro_ids" {
    type        = list(number)
    description = "POST requests only. List of macro IDs to be recorded in the ticket audit."
    optional    = true
  }

  param "metadata" {
    type        = object({})
    description = "Write only. Metadata for the audit. In the audit object, the data is specified in the custom property of the metadata object. See Setting Metadata."
    optional    = true
  }

  param "organization_id" {
    type        = number
    description = "The organization of the requester. You can only specify the ID of an organization associated with the requester. See Organization Memberships."
    optional    = true
  }

  param "priority" {
    type        = string
    description = "The urgency with which the ticket should be addressed. Allowed values are 'urgent', 'high', 'normal', or 'low'."
    optional    = true
  }

  param "problem_id" {
    type        = number
    description = "For tickets of type 'incident', the ID of the problem the incident is linked to."
    optional    = true
  }

  param "raw_subject" {
    type        = string
    description = "The dynamic content placeholder, if present, or the 'subject' value, if not. See Dynamic Content Items."
    optional    = true
  }

  param "recipient" {
    type        = string
    description = "The original recipient e-mail address of the ticket. Notification emails for the ticket are sent from this address."
    optional    = true
  }

  param "requester" {
    type = object({
      name  = string
      email = string
    })
    description = "Write only. See Creating a ticket with a new requester."
    optional    = true
  }

  param "requester_id" {
    type        = number
    description = "The user who requested this ticket."
    optional    = true
  }

  param "safe_update" {
    type        = bool
    description = "Write only. Optional boolean. When true and an update_stamp date is included, protects against ticket update collisions and returns a message to let you know if one occurs. See Protecting against ticket update collisions. A value of false has the same effect as true. Omit the property to force the updates to not be safe."
    optional    = true
  }

  param "satisfaction_rating" {
    type = object({
      score        = number
      comment      = string
      reason       = string
      created_at   = string
      updated_at   = string
      assignee_id  = number
      group_id     = number
      requester_id = number
    })
    description = "The satisfaction rating of the ticket, if it exists, or the state of satisfaction, 'offered' or 'unoffered'. The value is null for plan types that don't support CSAT."
    optional    = true
  }

  param "sharing_agreement_ids" {
    type        = list(number)
    description = "The IDs of the sharing agreements used for this ticket."
    optional    = true
  }

  param "status" {
    type        = string
    description = "The state of the ticket. If your account has activated custom ticket statuses, this is the ticket's status category. See custom ticket statuses. Allowed values are 'new', 'open', 'pending', 'hold', 'solved', or 'closed'."
    optional    = true
  }

  param "subject" {
    type        = string
    description = "The value of the subject field for this ticket."
    optional    = true
  }

  param "submitter_id" {
    type        = number
    description = "The user who submitted the ticket. The submitter always becomes the author of the first comment on the ticket."
    optional    = true
  }

  param "tags" {
    type        = list(string)
    description = "The array of tags applied to this ticket."
    optional    = true
  }

  param "ticket_form_id" {
    type        = number
    description = "Enterprise only. The ID of the ticket form to render for the ticket."
    optional    = true
  }

  param "type" {
    type        = string
    description = "The type of this ticket. Allowed values are 'problem', 'incident', 'question', or 'task'."
    optional    = true
  }

  param "updated_at" {
    type        = string
    description = "When this record last got updated."
    optional    = true
  }

  param "updated_stamp" {
    type        = string
    description = "Write only. Datetime of last update received from API. See the safe_update property."
    optional    = true
  }

  param "url" {
    type        = string
    description = "The API URL of this ticket."
    optional    = true
  }

  param "via" {
    type = object({
      channel = string
    })
    description = "For more information, see the Via object reference."
    optional    = true
  }

  param "via_followup_source_id" {
    type        = number
    description = "POST requests only. The ID of a closed ticket when creating a follow-up ticket. See Creating a follow-up ticket."
    optional    = true
  }

  param "via_id" {
    type        = number
    description = "Write only. For more information, see the Via object reference."
    optional    = true
  }

  param "voice_comment" {
    type = object({
      value = string
    })
    description = "Write only. See Creating voicemail ticket."
    optional    = true
  }

  step "http" "create_ticket" {
    method = "post"
    url    = "https://${credential.zendesk[param.cred].subdomain}.zendesk.com/api/v2/tickets.json"
    request_headers = {
      Content-Type  = "application/json"
      Authorization = "Basic ${base64encode("${credential.zendesk[param.cred].email}/token:${credential.zendesk[param.cred].token}")}"
    }
    request_body = jsonencode({ ticket = { for name, value in param : name => value if value != null } })
  }

  output "ticket" {
    description = "The ticket that has been created."
    value       = step.http.create_ticket.response_body.ticket
  }
}
