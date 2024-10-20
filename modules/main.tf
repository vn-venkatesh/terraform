# Provider Configuration
provider "google" {
  project = var.project_id
  region  = var.region
  credentials = file(var.credentials_file)
}

# Resource Blocks

# Create a VPC network
resource "google_compute_network" "vpc_network" {
  name                    = var.network_name
  auto_create_subnetworks = false
}

# Create a public subnet
resource "google_compute_subnetwork" "public_subnet" {
  name          = "${var.network_name}-subnet"
  ip_cidr_range = var.subnet_cidr
  network       = google_compute_network.vpc_network.self_link
  region        = var.region
}

# Create a compute instance (VM)
resource "google_compute_instance" "vm_instance" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network    = google_compute_network.vpc_network.self_link
    subnetwork = google_compute_subnetwork.public_subnet.self_link
    access_config {
      # This is for a public IP
    }
  }

  tags = ["web", "app-server"]
}

# 3. Outputs
output "instance_name" {
  description = "The name of the Compute Instance"
  value       = google_compute_instance.vm_instance.name
}

output "instance_ip" {
  description = "The public IP address of the instance"
  value       = google_compute_instance.vm_instance.network_interface[0].access_config[0].nat_ip
}
