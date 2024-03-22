variable "gce_instance_template" {
  type = string
}

variable "machine_type" {
  type  = string
}

variable "image"{
    type = string
}

variable "project_id" {
  type = string
}

variable "labels" {
    default = {}
}

variable "size" {
  type = number
}

variable "disk_type" {
    default = "pd-balanced"
}

variable "on_host_maintenance" {
  default = "MIGRATE"
}

variable "automatic_restart" {
  default = true
}

variable "attached_disk_image" {
  type = string
}

variable "attached_disk_size" {
  type = number
}

variable "zone" {
  type = string
}

variable "region" {
  type = string
}

variable "mig_zones" {
  type = list
  default = []
}

# variable "ip" {
#   type = list
#   default = []
# }

# variable "vm_ip_list" {
#   type = list
#   default = []
# }

variable "vm_type" {}

variable "vendor_name" {}


variable "countt" {
  type = list(number)
  default = [1,2,3]
}