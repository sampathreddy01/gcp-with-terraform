module "create_vpc" {
    source     = "../module/network"
    project_id = "burner-ettreddy"
    vpc_name = "test-vpc"
    subnet_name = "test-vpc-subnet-1"
    ip_cidr_range = "10.2.0.0/24"
    region        = "us-central1"
}

module create_firewall_rule {
  source                = "../module/firewall"
  firewall_name         = "test-firewall"
  firewall_direction    = "INGRESS"
  firewall_priority     = 1000
  firewall_source_range = ["0.0.0.0/0"]
  target_tags           = ["allow-https"]
}

# module dataproc_creation {
#   source                = "../module/spark-cluster"
#   vpc_name = "test-vpc"
#   subnet_name = "test-vpc-subnet-1"
#   region = "us-central1"
#   labels= var.labels
# }
# module compute_address_creation {
#   source                = "../module/compute-address"
#   project_id = "burner-ettreddy"
#   region        = "us-central1"
#   zone    = "us-central1-a"
#   vm_name = ["vm-1","vm-2"]
# }

# module gcp_gce_creation {
#   source       = "../module/compute-instance"
#   gce_name         = "test-rhel-instance"
#   image        = "rhel-cloud/rhel-7"
#   machine_type = "e2-medium"
#   zone         = "us-central1-a"
#   project_id = "burner-ettreddy"
#   allow_stopping_for_update = true
#   labels = var.labels
#   script_version_label = var.script_version_label
#   size = 75
#   disk_image = "rhel-7-v20220719"
#   disk_size = 25
#   developer_keys = var.developer_keys
# }

# module gcp_gce_template_creation {
#   source       = "../module/instance-template"
#   gce_instance_template     = "test-rhel-template-instance"
#   image        = "rhel-cloud/rhel-7"
#   machine_type = "e2-medium"
#   project_id = "burner-ettreddy"
#   labels = var.labels
#   size = 75
#   # ip = ["10.2.0.2","10.2.0.3"]
#   # vm_suffix = ["vm-1","vm-2"]
#   zone         = "us-central1-a"
#   attached_disk_image = "rhel-7-v20220719"
#   attached_disk_size = 25
#   region        = "us-central1"
#   mig_zones     = ["us-central1-a"]
# }