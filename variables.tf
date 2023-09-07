variable "subscription_id" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "virtual_network_name" {
  type = string
}

variable "subnet_gateway_address_prefix" {
  type = string
}

variable "location" {
  type = string
}

variable "gateway_address" {
  type = string
}

variable "address_space" {
  type = string
}

variable "shared_key" {
  type        = string
  description = "description"
  sensitive   = true
}
