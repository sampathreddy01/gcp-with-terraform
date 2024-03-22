variable "firewall_name" {
    type = string
}

variable "firewall_direction" {
    type = string
}

variable "firewall_priority" {
    type = number
}  

variable "firewall_source_range" {
    type = list(string)
}

variable "target_tags" {
  type = list(string)
}