variable "instance_name" {
  description = "The name of the compute instance"
  type        = string
}

variable "instance_type" {
  description = "The machine type of the compute instance"
  type        = string
}

variable "instance_image" {
  description = "The image used for the boot disk"
  type        = string
}

variable "zone" {
  description = "The zone where the instance is deployed"
  type        = string
}

variable "network_name" {
  description = "The name of the network to attach the instance"
  type        = string
}

variable "instance_tags" {
  description = "Tags to assign to the instance"
  type        = list(string)
  default     = ["http-server", "https-server"]
}