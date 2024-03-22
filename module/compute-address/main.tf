resource "google_compute_address" "vm_address" {
  count = length(var.vm_name)
  project = var.project_id
  subnetwork = "projects/burner-ettreddy/regions/us-central1/subnetworks/test-vpc-subnet-1"
  region = var.region
  address_type = "INTERNAL"
  name = "mq01-${var.vm_name[count.index]}-ip"
}
