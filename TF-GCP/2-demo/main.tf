
// Configure the Google Cloud provider
provider "google" {
  region = "asia-southeast1"
}

terraform {
  backend "remote" {
    hostname     = "trivbuit.scalr.io"
    organization = "env-tct37d1oddo7u4g"

    workspaces {
      name = "Demo_GCP"
    }
  }
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

// A single Compute Engine instance
resource "google_compute_instance" "default" {
  name         = "vm-${random_id.instance_id.hex}"
  machine_type = "e2-medium"
  zone         = "asia-southeast1-a"

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Include this section to give the VM an external ip address
    }
  }

  metadata = {
    ssh-keys = "trb:${file("id.pub")}"
  }

}

// A variable for extracting the external IP address of the instance
output "ip" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}