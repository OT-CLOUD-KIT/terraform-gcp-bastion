variable "project_id" {
  type        = string
  description = "The project ID to host the network in."
}

variable "region" {
  type        = string
  description = "The region to use"
}

variable "zone" {
  type        = string
  description = "The zone where the Bastion host is located in."
}

variable "bastion_name" {
  type        = string
  description = "The name to use for the bastion instance."
}

variable "machine_type" {
  description = "The machine type of the instance."
  type        = string
  default     = "e2-micro"
}

variable "network_name" {
  type        = string
  description = "The name of the network that should be used."
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet that should be used."
}


variable "credentials_file_path" {
  type        = string
  description = "The credentials JSON file used to authenticate with GCP"
}

variable "tag" {
  description = "The GCP network tag to apply to the bastion host for firewall rules. Defaults to 'public', the expected public tag of this module."
  type        = list(string)
  default     = ["public","bastion"]
}

variable "source_image" {
  description = "The source image to build the VM using. Specified by path reference or by {{project}}/{{image-family}}"
  type        = string
  default     = "debian-cloud/debian-10"
}
