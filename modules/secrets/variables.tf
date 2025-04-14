
variable "secrets" {
  description = "Map of secrets with data, labels, annotations, and IAM access"
  type = map(object({
    value       = string
    labels      = map(string)
    annotations = map(string)
    accessors   = list(string)
  }))
}
