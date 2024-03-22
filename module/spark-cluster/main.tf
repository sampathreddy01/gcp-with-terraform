resource "google_storage_bucket" "spark_bucket" {
    name          = "ettreddy-spark-storagebucket-dbtest"
    location      = "US"
    force_destroy = true
}

resource "google_storage_bucket" "spark_cluster_temp_bucket" {
    name          = "ettreddy-spark-storagebucket-dbtesttemp"
    location      = "US"
    force_destroy = true
}

resource "google_dataproc_cluster" "mycluster" {
  name     = "mycluster-6dfa"
  region   = var.region
  graceful_decommission_timeout = "120s"
  labels = var.labels

  cluster_config {
    staging_bucket = google_storage_bucket.spark_bucket.name
    temp_bucket = google_storage_bucket.spark_cluster_temp_bucket.name

    master_config {
      num_instances = 1
      machine_type  = "n1-standard-8"
      disk_config {
        boot_disk_type    = "pd-standard"
        boot_disk_size_gb = 500
        num_local_ssds    = 2
      }
    }

    # worker_config {
    #   num_instances    = 2
    #   machine_type     = "n1-standard-4"
    # #   min_cpu_platform = "Intel Skylake"
    #   disk_config {
    #     boot_disk_size_gb = 500
    #     boot_disk_type    = "pd-standard"
    #     num_local_ssds    = 2
    #   }
    # }

    preemptible_worker_config {
      num_instances = 0
    }

    # Override or set some custom properties
    software_config {
      image_version = "2.0-debian10"
      override_properties = {
        "dataproc:dataproc.allow.zero.workers" = "true"
      }
    }

    gce_cluster_config {
      zone = "us-central1-a"
      subnetwork  = "projects/burner-ettreddy/regions/us-central1/subnetworks/test-vpc-subnet-1"
      tags = ["allow-https"]
      # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    #   service_account = google_service_account.default.email
    #   service_account_scopes = [
    #     "cloud-platform"
    #   ]
    }

    # You can define multiple initialization_action blocks
#     initialization_action {
#       script      = "gs://dataproc-initialization-actions/stackdriver/stackdriver.sh"
#       timeout_sec = 500
#     }
  }
}