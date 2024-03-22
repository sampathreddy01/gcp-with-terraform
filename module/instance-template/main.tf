resource "google_compute_disk" "gce_persistent_disk" {
  count = length(var.vm_ip_list)
  name         = "${var.vendor_name}-vm-${var.vm_type}-${count.index+1}-attached-disk"
  zone         = var.zone
  project = var.project_id
  labels = var.labels
  type = "pd-ssd"
  image = var.attached_disk_image
  size = var.attached_disk_size
}

# resource "google_compute_address" "vm_address" {
#   count = length(var.vm_suffix)
#   project = var.project_id
#   subnetwork = "projects/burner-ettreddy/regions/us-central1/subnetworks/test-vpc-subnet-1"
#   region = var.region
#   address_type = "INTERNAL"
#   name = "static-ip-${var.vm_suffix[count.index]}"
# }

locals {
  timestamp = "${timestamp()}"
  timestamp_sanitized = "${replace("${local.timestamp}","/[- TZ:]/", "")}"
}

resource "google_compute_instance_template" "default" {
  count = length(var.vm_ip_list)
  name = "${var.vendor_name}-vm-${var.vm_type}-${count.index+1}-template-${local.timestamp_sanitized}"
  description = "This template is used to create rhel linux instances."
  instance_description = "change in description to test"
  project = var.project_id
  machine_type = var.machine_type

  tags = ["allow-https"]

  labels = var.labels

  can_ip_forward       = false

  // Create a new boot disk from an image
  disk {
    source_image      = var.image
    disk_type = var.disk_type
    disk_size_gb = var.size
    type = "PERSISTENT"
    mode = "READ_WRITE"
    auto_delete       = true
    boot              = true
  }

  //attcahed disk
  # disk {
  #   source_image = "rhel-7-v20220719"
  #   disk_type = var.disk_type
  #   disk_size_gb = var.attached_disk_size
  #   labels = var.labels
  #   type = "PERSISTENT"
  #   mode = "READ_WRITE"
  #   disk_name = "${var.vendor_name}-vm-${var.vm_type}-${count.index+1}-attached-disk"
  #   auto_delete       = false
  #   boot              = false
  # }
  disk {
    source      = google_compute_disk.gce_persistent_disk[count.index].name
    auto_delete = false
    boot        = false
  }
  
  scheduling {
    on_host_maintenance = var.on_host_maintenance
    automatic_restart = var.automatic_restart
  }

  shielded_instance_config {
    enable_secure_boot = true
  }

  lifecycle {
    create_before_destroy = true
  }

  network_interface {
    network = "test-vpc"
    subnetwork = "projects/burner-ettreddy/regions/us-central1/subnetworks/test-vpc-subnet-1"
    network_ip = var.vm_ip_list[count.index]
  }


  metadata = {
    "startup-script" = "${file("${path.module}/tools.sh")}"
    "shutdown-script" = file("${path.module}/shutdown-script.sh")
  }
}

resource "google_compute_instance_group_manager" "name" {
  count = length(var.vm_ip_list)
  name  = "${var.vendor_name}-vm-${var.vm_type}-${count.index+1}-mig-${local.timestamp_sanitized}"
  project = var.project_id
  base_instance_name = "${var.vendor_name}-${var.vm_type}-${count.index+1}-mig-vm"
  zone = var.zone

  target_size = 0
  version {
    name = "${var.vendor_name}-vm-${var.vm_type}-${count.index+1}-vm-template-version"
    instance_template = google_compute_instance_template.default[count.index].id
  }

  update_policy {
    type = "PROACTIVE"
    minimal_action = "REPLACE"
    # instance_redistribution_type = "NONE"
    max_unavailable_fixed = 1
    replacement_method = "RECREATE"
  }
}

resource "google_compute_per_instance_config" "test" {
  count = length(var.vm_ip_list)
  zone = var.zone
  instance_group_manager = google_compute_instance_group_manager.name[count.index].name
  name = "${var.vendor_name}-vm-${var.vm_type}-${count.index+1}-${local.timestamp_sanitized}"
  preserved_state {
    metadata = {
      instance_template = google_compute_instance_template.default[count.index].self_link
    }
  }
}
