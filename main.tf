locals {
  hostname = format("%s-bastion", var.bastion_name)
}

// Dedicated service account for the Bastion instance.
resource "google_service_account" "bastion" {
  account_id   = format("%s-bastion-sa", var.bastion_name)
  display_name = "Bastion Service Account"
}

// Allow access to the Bastion Host via SSH.
resource "google_compute_firewall" "bastion-ssh" {
  name          = format("%s-bastion-ssh", var.bastion_name)
  network       = var.network_name
  direction     = "INGRESS"
  project       = var.project_id
  source_ranges = ["0.0.0.0/0"] // TODO: Restrict further.

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = var.tag
}

// The user-data script on Bastion instance provisioning.
data "template_file" "startup_script" {
  template = <<-EOF
  sudo apt-get update -y
  sudo apt-get install -y tinyproxy
  EOF
}

// The Bastion host.
resource "google_compute_instance" "bastion" {
  name         = local.hostname
  machine_type = var.machine_type
  zone         = var.zone
  project      = var.project_id
  tags         = var.tag	

  boot_disk {
    initialize_params {
      image = var.source_image
    }
  }

  shielded_instance_config {
    enable_secure_boot          = true
    enable_vtpm                 = true
    enable_integrity_monitoring = true
  }

  // Install tinyproxy on startup.
  metadata_startup_script = data.template_file.startup_script.rendered


 network_interface {
   network = var.network_name
    access_config {
      // Not setting "nat_ip", use an ephemeral external IP.
    }
  }

  // Allow the instance to be stopped by Terraform when updating configuration.
  allow_stopping_for_update = true

  service_account {
    email  = google_service_account.bastion.email
    scopes = ["cloud-platform"]
  }


  scheduling {
    preemptible       = true
    automatic_restart = false
  }
}
