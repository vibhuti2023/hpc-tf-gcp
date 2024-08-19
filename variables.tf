variable "parent_folder" {
  type = string
  description = "A GCP folder id (folders/FOLDER-ID) that contains the Fluid-Slurm-GCP controller project and compute partition projects. This folder setting is useful for multi-project deployments."
  default = ""
}

variable "cloudsql_slurmdb" {
  type = bool
  description = "Boolean flag to enable (True) or disable (False) CloudSQL Slurm Database"
  default = false
}

variable "cloudsql_name" {
  type = string
  description = "Name of the cloudsql instance used to host the Slurm database, if cloudsql_slurmdb is set to true"
  default = "slurmdb"
}

variable "cloudsql_tier" {
  type = string
  description = "Instance type of the CloudSQL instance. See https://cloud.google.com/sql/docs/mysql/instance-settings for more options."
  default = "db-n1-standard-8"
}
variable "cluster_name" {
  type = string
  description = "Customer organization ID from the managed-fluid-slurm-gcp customers database"
}

variable "subnet_cidr" {
  type = string
  description = "CIDR Range for controller/login VPC Subnet."
  default = "10.10.0.0/16"
}

variable "slurm_gcp_admins" {
  type = list(string)
  description = "A list of users that will serve as Linux System Administrators on your cluster. Set each element to 'user:someone@example.com' for users or 'group:somegroup@example.com' for groups"
}

variable "slurm_gcp_users" {
  type = list(string)
  description = "A list of users that will serve as Linux System Administrators on your cluster. Set each element to 'user:someone@example.com' for users or 'group:somegroup@example.com' for groups"
}

variable "controller_image" {
  type = string
  description = "Image to use for the fluid-slurm-gcp controller"
  default = "projects/fluid-cluster-ops/global/images/fluid-slurm-gcp-controller-centos-v2-6"
}

variable "compute_image" {
  type = string
  description = "Image to use for the fluid-slurm-gcp compute instances (all partitions[].machines[])."
  default = "projects/fluid-cluster-ops/global/images/fluid-slurm-gcp-compute-centos-v2-6"
}

variable "login_image" {
  type = string
  description = "Image to use for the fluid-slurm-gcp login node"
  default = "projects/fluid-cluster-ops/global/images/fluid-slurm-gcp-login-centos-v2-6"
}

variable "primary_project" {
  type = string
  description = "Main GCP project ID for the customer's managed solution"
}

variable "primary_zone" {
  type = string
  description = "Main GCP zone for the customer's managed solution"
}

variable "whitelist_ssh_ips" {
  type = list(string)
  description = "IP addresses that should be added to a whitelist for ssh access"
  default = ["0.0.0.0/0"]
}

variable "controller_machine_type" { 
  type = string
  description = "GCP Machine type to use for the login node."
}

variable "controller_disk_size_gb" { 
  type = number
  description = "Size of the controller boot disk in GB."
  default = 100
}

variable "default_partition" {
  type = string
  description = "Name of the default compute partition."
  default = ""
}

variable "login_machine_type" {
  type = string
  description = "GCP Machine type to use for the login node."
}

variable "login_disk_size_gb" { 
  type = number
  description = "Size of the login boot disk in GB."
  default = 100
}

variable "partitions" {
  type = list(object({
      name = string
      project = string
      max_time= string
      labels = map(string)
      machines = list(object({
        name = string
        disk_size_gb = number
        gpu_count = number
        gpu_type = string
        image = string
        machine_type=string
        max_node_count= number
        preemptible_bursting= bool
        zone= string
      }))
  }))
  description = "Settings for partitions and compute instances available to the cluster."
  
  default = []
}

variable "slurm_accounts" {
  type = list(object({
      name = string
      users = list(string)
      allowed_partitions = list(string)
  }))
  default = []
}

variable "munge_key" {
  type = string
  default = ""
}

variable "suspend_time" {
  type = number
  default = 300
}
