variable "aws_region" {
  type    = string
  default = "eu-central-1"
}

variable "instance_type" {
  type    = string
  default = "t3.micro"
}

variable "project_prefix" {
  type    = string
  default = "w3combo"
}
variable "key_name" {
  type    = string
  default = "w3-key-fotios"

}


# 1, 2, or 3 (for Milestones)
variable "milestone" {
  type    = number
  default = 1
  validation {
    condition     = contains([1,2,3], var.milestone)
    error_message = "milestone must be 1, 2, or 3."
  }
}
