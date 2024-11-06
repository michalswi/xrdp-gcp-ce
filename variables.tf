variable "name" {
  description = "The name to be used for resources that will be created."
  type        = string
  default     = "rdp"
}

variable "project" {
  description = "The ID of the project in which resources will be managed."
  type        = string
}

variable "region" {
  description = "The region in which resources will be created."
  type        = string
  default     = "europe-central2"
}

variable "user" {
  description = "The username to be used for the resources."
  type        = string
}
