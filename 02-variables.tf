# Define Input Variables
# 1. Azure Location (CentralUS)
# 2. Azure Resource Group Name 
# 3. Azure AKS Environment Name (Dev, QA, Prod)

# Azure Location
variable "location" {
  type        = string
  description = "Azure Region where all these resources will be provisioned"
  default     = "eastus2"
}

# Azure Resource Group Name
variable "resource_group_name" {
  type        = string
  description = "This variable defines the Resource Group"
  default     = "testtfcluster-delete"
}

# Azure AKS Environment Name
variable "environment" {
  type        = string
  description = "This variable defines the Environment"
  default     = "dev"
}


# AKS Input Variables

# SSH Public Key for Linux VMs
variable "ssh_public_key" {
  default     = "publickeyfile.pub"
  description = "This variable defines the SSH Public Key for Linux k8s Worker nodes"
}

variable "aks_disk" {
  default = "Standard_D4as_v4"
}

variable "postgres_sku" {
  default = "GP_Standard_D2s_v3"
}

variable "administrator_login" {}
variable "administrator_password" {}
variable "vnet" {}
variable "subnet1" {}
variable "subnet2" {}
