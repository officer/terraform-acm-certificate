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
  default     = "us-east-1"
}
variable "subject_alternative_names" {
  description = "(Optional) SANs a.k.a Subject Alternative Names"
  type        = "list"
  default     = []
}

variable "tags" {
  description = "(Optional) Tags for resource"
  type        = "map"
  default     = {}
}