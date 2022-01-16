


provider "google" {
  project = var.ADMIN_PROJECT
  region  = var.REGION
  zone    = var.ZONE
  credentials = var.FME_ADMIN_CRED
}

#### Create vpc ######

resource "google_compute_network" "vpc_network" {  
    project   = var.ADMIN_PROJECT
    name = var.FME_NETWORK_NAME
    auto_create_subnetworks = false
  delete_default_routes_on_create = true
    mtu = 0
}

##### Create subnets ########

resource "google_compute_subnetwork" "public-subnetwork-1" {
name = var.FME_SN_1_NAME
ip_cidr_range = var.FME_SN_1
region = var.REGION
network = google_compute_network.vpc_network.name
}
resource "google_compute_subnetwork" "public-subnetwork-2" {
name = var.FME_SN_2_NAME
ip_cidr_range = var.FME_SN_2
region = var.REGION
network = google_compute_network.vpc_network.name
}

resource "google_compute_subnetwork" "private-subnetwork-1" {
name = var.FME_SN_3_NAME
ip_cidr_range = var.FME_SN_3
region = var.REGION
network = google_compute_network.vpc_network.name
}
resource "google_compute_subnetwork" "priave-subnetwork-2" {
name = var.FME_SN_4_NAME
ip_cidr_range = var.FME_SN_4
region = var.REGION
network = google_compute_network.vpc_network.name
}


####### Create compute instances #####

resource "google_compute_instance" "default" {
  name         = var.FME_FRONTEND_NAME
  machine_type = var.MACHINE_TYPE
  zone         = var.ZONE
  boot_disk {
    initialize_params {
      image = var.MACHINE_IMAGE
    }
  }

  network_interface {
    network = var.FME_NETWORK_NAME
    subnetwork = var.FME_SN_1_NAME

    access_config {
       // Ephemeral public IP
    }
  }

//  metadata_startup_script = "echo hi > /test.txt"

}
resource "google_compute_instance"  {
  name         = var.FME_BACKEND_NAME
  machine_type = var.MACHINE_TYPE
  zone         = var.ZONE
  boot_disk {
    initialize_params {
      image = var.MACHINE_IMAGE
    }
  }

  network_interface {
    network = var.FME_NETWORK_NAME
    subnetwork = var.FME_SN_3_NAME

   // access_config {
       // Ephemeral public IP
   // }
  }

//  metadata_startup_script = "echo hi > /test.txt"

}
