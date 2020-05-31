##############################
## Core Network - Variables ##
##############################

variable "vnet_address_space" {

  description = "The CIDR of the network VNET"
}

variable "subnet_prefix" {
  description = "The CIDR for the network subnet"
}


variable "vnet_address_space_Common" {

  description = "The CIDR of the network Common VNET"
}

variable "subnet_prefix_Common" {
  description = "The CIDR for the network Common subnet"
}

variable "vnet_address_space_VDI" {

  description = "The CIDR of the network VDI VNET"
}

variable "subnet_prefix_VDI" {
  description = "The CIDR for the network VDI subnet"
}


variable "vnet_address_space_LAB" {

  description = "The CIDR of the network LAB VNET"
}

variable "subnet_prefix_LAB" {
  description = "The CIDR for the network LAB subnet"
}