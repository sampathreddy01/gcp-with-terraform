# variable "secondary_ip_range" {
#   type = object({
#     range_name = string
#     secondary_ip_range = string
#   })
#   default = {
#     range_name = "tf-test-secondary-range-update1"
#     ip_cidr_range = "192.168.10.0/28"
#   }
# }

variable "labels" {
  default = {
    environment = "dev"
  }
}

variable "script_version_label" {
  default = {
    script = "v1"
  }
}

variable "developer_keys" {
  default = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDCdZylPH2l+NbUpZ8BgP2di/9k9/tQdNj1arQXJ0vIohjLYIuqiPm6ZD6p6lzMBCncDVr1bOl2gOVLqDO3VtVQmXyWuoJWRv7n1yRA/gRMIyYqM223CYlSjLZy8iObw4BhGiIjDkf4TaserfhI7iJ9hruyikdyAQyInbjbDOjevG1kM7pKXHV2lvMMlzfcIDS2fX1KFQsOo2EegYl4YZbllr6Bd2BS/8E+ryyHe0AYZ8xuMEVjfEyW5YOuyi2XU6djXeixTi2OfYstzuV6l9BRdpvphZPjNYpvUkxVhpCz8nv4d4Md8oNOdu/L2Yt1rda6i2OUtl8HSOk1ZudPErLiPAYE2nzfSoVg+vUNE12vYixM9e6kmd54RE4ZSGWArkvqSMRybz6jMUsloZZn5ttRKmdB9Zj8BvnxHaqt2fx+TlXdoN5B0saDhDzUeXFFg+K4hO+wQrMRaKQbF5lhEAZGIjGbW3s2FART43kGBokFdgK5BCftr13AlfNk24FW0Qk= ettreddy"
  ]
}

# variable "vendor_ip_config" {
#   description = "vendor config"
#   default = {
#     # vendor1 = {
#     #     rhel_ip_list = ["10.2.0.2","10.2.0.3"]
#     # }
#     vendor2 = {
#         rhel_ip_list = ["10.2.0.6"]
#     }
# }
# }