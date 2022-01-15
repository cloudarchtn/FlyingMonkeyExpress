


provider "google" {
  project = var.ADMIN_PROJECT
  region  = var.REGION
  zone    = var.ZONE
  credentials = var.FME_ADMIN_CRED
}

resource "google_compute_network" "vpc_network" {  
    project_id   = var.ADMIN_PROJECT
    name = var.FME_NETWORK_NAME
    auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "public-subnetwork" {
name = var.FME_SN_1
ip_cidr_range = "10.0.0.0/24"
region = var.REGION
network = google_compute_network.vpc_network.name
}
