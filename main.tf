
provider "google" {
  version = "3.5.0"
  project = "flyingmonkeyadmin"
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = var.FME_ADMIN_CREDS
}
resource "google_compute_network" "vpc_network" {
name = "FME-network"
}
resource "google_compute_subnetwork" "public-subnetwork" {
name = "fme-subnet1"
ip_cidr_range = "10.0.0.0/24"
region = var.region
network = google_compute_network.vpc_network.name
}
