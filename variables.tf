### placeholder needed so that values can be passed from TF Cloud ###
### a better way of creating variable would be to use string concatenation ###
### to build standardized labeling and forcing all names to conform to formulas ###

variable "FME_FRONTEND_NAME" {
  type = string
  default = ""
}
variable "FME_BACKEND_NAME" {
  type = string
  default = ""
}
variable "FME_NETWORK_NAME" {
  type = string
  default = ""
}
variable "FME_SN_1_NAME" {
  type = string
  default = ""
}
variable "FME_SN_2_NAME" {
  type = string
  default = ""
}
variable "FME_SN_3_NAME" {
  type = string
  default = ""
}
variable "FME_SN_4_NAME" {
  type = string
  default = ""
}

variable "FME_SN_1" {
  type = string
  default = ""
}
variable "FME_SN_2" {
  type = string
  default = ""
}
variable "FME_SN_3" {
  type = string
  default = ""
}
variable "FME_SN_4" {
  type = string
  default = ""
}
variable "MACHINE_TYPE" {
  type = string
  default = ""
}
variable "INSTANCE_NAME" {
  type = string
  default = ""
}
variable "ADMIN_PROJECT" {
  type = string
   default = ""
}
variable "APP_PROJECT" {
  type = string
  default = ""
}
variable "REGION" {
  type = string
  default = ""
}
variable "ZONE" {
  type = string
  default = ""
}
variable "MACHINE_IMAGE" {
  type = string
  default = ""
}
variable "MACHINE_IMAGE2" {
  type = string
  default = ""
}
variable "FME_ADMIN_CRED" {
  type = string
  default = ""
}
variable "FME_APP_CRED" {
  type = string
  default = ""
}
### ok I cheated here and did not move the fw rule names over to TF Cloud ###
variable "FME_Firewall_Internal_Allow" {
  type = string
  default = "fme-fw-internal-allow"
}
variable "FME_Firewall_ICMP_Allow" {
  type = string
  default = "fme-fw-icmp-allow"
}


variable "FME_Firewall_TCP_Allow" {
  type = string
  default = "fme-fw-tcp-allow"
}
variable "FME_Firewall_SSH_Allow" {
  type = string
  default = "fme-fw-ssh-allow"
}
