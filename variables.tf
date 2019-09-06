# Required attributes
variable "zone_id" {
  description = "(Required) Route53 Hosted zone id"
  type = "string"
}

variable "domain_name" {
  description = "(Required) Domain name"
  type = "string"
}

# Optional attributes
variable "region" {
  description = "(Optional) Region. if not, current region will be used."
  type        = "string"
  default     = "none"
}
variable "subject_alternative_names" {
  description = "(Optional) SANs a.k.a Subject Alternative Names"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "Tags for resource"
  type = "map"
}