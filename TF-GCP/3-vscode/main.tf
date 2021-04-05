
// Configure the Google Cloud provider
provider "google" {
  region = "asia-southeast1"
}

// Config remote backend
terraform {
  backend "remote" {
    hostname     = "trivbuit.scalr.io"
    organization = "env-tct37d1oddo7u4g"

    workspaces {
      name = "GCP_Run_Web"
    }
  }
}

// Terraform plugin for creating random ids
resource "random_id" "instance_id" {
  byte_length = 8
}

// Create a Google Compute Firewall
resource "google_compute_firewall" "trb_firewall" {
  name    = "trb-firewall"
  network = "default"

  source_ranges = ["0.0.0.0/0"]

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }
}

// A single Compute Engine instance
resource "google_compute_instance" "trb_instance" {
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

  // Make sure flask is installed on all new instances for later steps
  metadata_startup_script = "sudo yum update -y; sudo yum -y install httpd"

  metadata = {
    ssh-keys = "trb:${file("id.pub")}"
  }

}

// A variable for extracting the external IP address of the instance
output "ip" {
  value = google_compute_instance.trb_instance.network_interface.0.access_config.0.nat_ip
}