
module "vpc" {
    source  = "terraform-google-modules/network/google//modules/vpc"
    version = "~> 2.0.0"

    project_id   = var.ADMIN_PROJECT
    network_name = "example-vpc"

    shared_vpc_host = false
}

provider "google" {
  project = var.ADMIN_PROJECT
  region  = "us-central1"
  zone    = "us-central1-c"
  credentials = var.FME_ADMIN_CRED
}
resource "google_compute_network" "vpc_network" {
region = var.REGION  
name = "fme-network"
}
resource "google_compute_subnetwork" "public-subnetwork" {
name = "fme-subnet1"
ip_cidr_range = "10.0.0.0/24"
region = var.REGION
network = google_compute_network.vpc_network.name
}
