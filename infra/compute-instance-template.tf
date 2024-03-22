module gcp_gce_template_creation {
  source       = "../module/instance-template-v2"
  # for_each = var.vendor_ip_config
  gce_instance_template     = "test-rhel-template-instance"
  image        = "rhel-cloud/rhel-7"
  machine_type = "e2-medium"
  project_id = "burner-ettreddy"
  labels = var.labels
  vendor_name = "vendor1"
  vm_type = "rhel"
  # vm_ip_list = each.value.rhel_ip_list
  size = 75
  # ip = ["10.2.0.2","10.2.0.3"]
  # count = 3
  zone         = "us-central1-a"
  attached_disk_image = "rhel-7-v20220719"
  attached_disk_size = 25
  region        = "us-central1"
  mig_zones     = ["us-central1-a", "us-central1-f"]
}