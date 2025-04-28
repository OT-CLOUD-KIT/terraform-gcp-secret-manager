variable "enable_secret_manager_api" {
  description = "Enable Secret Manager API in the project."
  type        = bool
  default     = false
}

variable "secrets" {
  description = "List of secrets with replication, data, IAM role and member."
  type = list(object({
    name                  = string
    secret_data           = string
    replication_type      = string                 # "auto" or "user_managed"
    replication_locations = optional(list(string)) # Needed only if user_managed
    role                  = optional(string)       # IAM role (optional)
    member                = optional(string)       # IAM member (optional)
  }))
}
