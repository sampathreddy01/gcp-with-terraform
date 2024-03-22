variable "project_id" {
  type = string
}

variable "vpc_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "region" {
  type = string
}

variable "ip_cidr_range" {
  type = string
}

# variable "secondary_ip_range" {
#   type = object({
#     range_name = string
#     ip_cidr_range = string
#   })
# }