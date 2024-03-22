variable "gce_name" {
  type = string
}

variable "machine_type" {
  type  = string
}

variable "zone" {
  type = string
}

variable "image"{
    type = string
}

variable "project_id" {
  type = string
}

variable "allow_stopping_for_update" {
  type = string
}

variable "labels" {
    default = {}
}

variable "size" {
  type = number
}

variable "disk_image" {
  type = string
}

variable "disk_size" {
  type = number
}

variable "script_version_label" {
  default = {}
}

variable "developer_keys" {
  default = []
}

# variable "metadata" {
#   default = {
#     startup-script = <<EOF
#     #!/bin/bash
#     echo "Launching instance"
#     set -e -x -u -o pipefail
#     rm -rf /root/.ssh
#     mkdir -p /root/.ssh
#     ${join ("\n",[for k in var.developer_keys : "echo \"${k}\" >> /root/.ssh/authorized_keys"])}
#     sed -i "s~PermitRootLogin.*~PermitRootLogin without -password~" /etc/ssh/sshd_config
#     sed -i "s~AuthorizedKeysFile.*~AuthorizedKeysFile .ssh\/authorized_keys .ssh\/authorized_keys2~" /etc/ssh/sshd_config
#     chmod 600 /root/.ssh/authorized_keys
#     systemctl restart sshd.service
#     EOF

#   }
# }