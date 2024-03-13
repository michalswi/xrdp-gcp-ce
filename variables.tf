variable "name" {
  type        = string
  default     = "rdp"
  description = "The name to be used for resources that will be created."
}

variable "project" {
  type        = string
  description = "The ID of the project in which resources will be managed."
}

variable "region" {
  type        = string
  default     = "us-central1"
  description = "The region in which resources will be created."
}

variable "user" {
  type        = string
  description = "The username to be used for the resources."
}
