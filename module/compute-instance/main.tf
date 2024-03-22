resource "google_compute_disk" "gce_persistent_disk" {
  name         = "${var.gce_name}-persistent-disk"
  zone         = var.zone
  project = var.project_id
  labels = var.labels
  type = "pd-ssd"
  image = var.disk_image
  size = var.disk_size
}


resource "google_compute_instance" "gce_creation" {
  name         = var.gce_name
  machine_type = var.machine_type
  zone         = var.zone
  project = var.project_id
  allow_stopping_for_update = var.allow_stopping_for_update

#   tags = module.create_firewall_rule.google_compute_firewall.gce_allow_tcp_firewall.target_tags
  tags = ["allow-https"]

  labels = merge(var.labels,var.script_version_label)

  description = "Test recreation"

  boot_disk {
    initialize_params {
      image = var.image
      size = var.size
    }
  }

  attached_disk {
    source = google_compute_disk.gce_persistent_disk.name
    mode = "READ_WRITE"
  }

#   network_interface {
#     network = module.create_vpc.google_compute_network.vpc_name.name
#     subnetwork = module.create_vpc.google_compute_subnetwork.subnet_name.self_link
#   }

  network_interface {
    network = "test-vpc"
    subnetwork = "projects/burner-ettreddy/regions/us-central1/subnetworks/test-vpc-subnet-1"
    network_ip = "10.2.0.6"
  }

  shielded_instance_config {
    enable_secure_boot = true
    enable_vtpm = true
    enable_integrity_monitoring = true
  }
  metadata = {
    "startup-script" = "${file("${path.module}/tools.sh")}"
    # "shutdown-script" = "${file("${path.module}/shutdown-script.sh")}"
  }

  # metadata = {
  #   starup-script = <<EOF
  #   #!/bin/bash
  #   echo "Launching instance"
  #   set -e -x -u -o pipefail
  #   rm -rf /root/.ssh
  #   mkdir -p /root/.ssh
  #   ${join ("\n",[for k in var.developer_keys : "echo \"${k}\" >> /root/.ssh/authorized_keys"])}
  #   sed -i "s~PermitRootLogin.*~PermitRootLogin without -password~" /etc/ssh/sshd_config
  #   sed -i "s~AuthorizedKeysFile.*~AuthorizedKeysFile .ssh\/authorized_keys .ssh\/authorized_keys2~" /etc/ssh/sshd_config
  #   chmod 600 /root/.ssh/authorized_keys
  #   systemctl restart sshd.service
  #   EOF
  # }
}