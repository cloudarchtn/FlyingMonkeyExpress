
provider "google" {
  project = var.ADMIN_PROJECT
  region  = var.REGION
  zone    = var.ZONE
  credentials = var.FME_ADMIN_CREDS
}
resource "google_compute_network" "vpc_network" {
name = "FME-network"
}
resource "google_compute_subnetwork" "public-subnetwork" {
name = "fme-subnet1"
ip_cidr_range = var.FME_SN_1
region = var.REGION
network = google_compute_network.vpc_network.name
}
