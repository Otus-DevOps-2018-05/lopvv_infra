resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "${var.zone}"
  tags         = ["reddit-app"]

  boot_disk {
    initialize_params {
      image = "${var.app_disk_image}"
    }
  }

  network_interface {
    network = "default"

    access_config = {
      nat_ip = "${google_compute_address.app_ip.address}"
    }
  }

  metadata {
    ssh-keys = "appuser:${file(var.public_key_path)}"
  }


}


resource "google_compute_address" "app_ip" {
  name = "reddit-app-ip"
}

data "template_file" "puma-service" {
  template = "${file("${path.module}/files/puma.service.tpl")}"

  vars {
    db_address = "${var.db_ip_address}"
  }
}
