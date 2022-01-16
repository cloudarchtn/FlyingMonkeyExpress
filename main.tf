


provider "google" {
  project = var.ADMIN_PROJECT
  region  = var.REGION
  zone    = var.ZONE
  credentials = var.FME_ADMIN_CRED
}

//provider "google-beta" {
//  project = var.ADMIN_PROJECT
//  region  = var.REGION
//  zone    = var.ZONE
//  credentials = var.FME_ADMIN_CRED
//}

//resource "google_project_service" "admin_project" {
//  project = var.ADMIN_PROJECT
//  service = "compute.googleapis.com"
//}

#### Create vpc ######

resource "google_compute_network" "vpc_network" {  
    project   = var.ADMIN_PROJECT
    name = var.FME_NETWORK_NAME
    auto_create_subnetworks = false
  delete_default_routes_on_create = false
    mtu = 0
  routing_mode = "GLOBAL"
}

/********* Firewall ******************
  ***************************************************/
  
resource "google_compute_firewall" "internal-allow" {
  name = var.FME_Firewall_Internal_Allow
  network = google_compute_network.vpc_network.name
  
 allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }
  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

source_ranges = [
    var.FME_SN_1,
    var.FME_SN_2,
    var.FME_SN_3,
    var.FME_SN_4
  ]
  }

resource "google_compute_firewall" "icmp-allow" {
  name = var.FME_Firewall_ICMP_Allow
  network = google_compute_network.vpc_network.name
   
  allow {
    protocol = "icmp"
  } 
  target_tags = ["icmp"]  
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "tcp-allow" {
  name = var.FME_Firewall_TCP_Allow
  network = google_compute_network.vpc_network.name
  
allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443"]
  }
   
  target_tags = ["http"]
  source_ranges = ["0.0.0.0/0"]
}


  
resource "google_compute_firewall" "ssh-allow" {
  name = var.FME_Firewall_SSH_Allow
  network = google_compute_network.vpc_network.name
  
allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags = ["ssh"] 
  source_ranges = ["0.0.0.0/0"]
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

/********** cannot create shared vpcs in this environment ****
  ********* no org set up ************************************
  

######## enable Shared VPC. #############
resource "google_project_service" "host_project" {
  project = var.ADMIN_PROJECT
  service = "compute.googleapis.com"
}


# Enable shared VPC hosting in the host project.
resource "google_compute_shared_vpc_host_project" "host_project" {
  project    = var.ADMIN_PROJECT
  depends_on = [google_project_service.host_project]
}

*******************************/

####### Create compute instances #####

resource "google_compute_instance" "default" {
  name         = var.FME_FRONTEND_NAME
  machine_type = var.MACHINE_TYPE
  zone         = var.ZONE
 
  tags = ["http", "ssh", "icmp"]
  
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
  allow_stopping_for_update = true

//metadata_startup_script = <<SCRIPT
//#! bin/bash
//sudo yum install httpd -y
//sudo systemctl start httpd
//sudo systemctl enable httpd
//SCRIPT

}

resource "google_compute_instance" "tlp" {
  name         = var.FME_BACKEND_NAME
  machine_type = var.MACHINE_TYPE
  zone         = var.ZONE
 
  tags = ["http", "ssh", "icmp"]
  
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
  allow_stopping_for_update = true

metadata_startup_script = <<SCRIPT
#! bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
SCRIPT

}
