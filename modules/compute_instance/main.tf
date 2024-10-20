resource "google_compute_instance" "default" {
  name         = var.instance_name
  machine_type = var.instance_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.instance_image
    }
  }

  network_interface {
    network = var.network_name
    access_config {}  # Include this to assign a public IP
  }

  tags = var.instance_tags
}