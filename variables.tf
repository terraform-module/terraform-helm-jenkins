variable "namespace" {
  description = "Namespace to where deploy CI/CD"
}

variable "apps" {
  type        = map
  description = "Multiple applications to deploy"
}

variable "repository" {
  type        = string
  description = "Collection of Helm repositories"
}