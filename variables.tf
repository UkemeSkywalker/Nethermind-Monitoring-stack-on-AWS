# variable "num" {
#   description = "Number of VM's with preconfigured Nethermind Docker environment to create"
# }

# variable "pvt_key" {}

variable "prefix" {
  description = "Instance prefix, this will be the basename of the host (e.g. <instance_name>-<instance-region>-<count>v)"
  type = string
  default = "nethermind"
}

variable "key_name" {
  description = "Instance Key name"
  type = string
  default = "Nethermind-Node"
}

variable "instance_type" {
  description = "EC2 instance type"
  type = string
  default = "c5.2xlarge"
}

variable "ami" {
  description = "EC2 instance Amazon Machine Image value"
  type = string
  default = "ami-0261755bbcb8c4a84"
}



# variable "client_count" {
#   description = "Number of Nethermind clients which will be running on each VM (e.g. --scale nethermind=5)"
#   type = number
# }

variable "config" {
  description = "Chain on which Nethermind will be running"
  type = string
}

variable "rpc_enabled" {
  description = "Specify whether JSON RPC should be enabled"
  type = bool
}

# variable "sizeList" {
#   type = map
#   default = {
#       "s-1vcpu-2gb" = "s-1vcpu-2gb"
#       "s-2vcpu-2gb" = "s-2vcpu-2gb"
#       "s-2vcpu-4gb" = "s-2vcpu-4gb"
#       "s-4vcpu-8gb" = "s-4vcpu-8gb"
#       "s-6vcpu-16gb" = "s-6vcpu-16gb"
#       "s-8vcpu-32gb" = "s-8vcpu-32gb"
#       "s-32vcpu-192gb" = "s-32vcpu-192gb"
#   }
# }

# variable "size" {
#   description = <<EOT
# "Choose VM size you wish to deploy e.g. s-2vcpu-2gb
# List of mappings is displayed below:
# s-1vcpu-2gb = 10USD
# s-2vcpu-2gb = 15USD
# s-2vcpu-4gb = 20USD
# s-4vcpu-8gb = 40USD
# s-6vcpu-16gb = 80USD
# s-8vcpu-32gb = 160USD
# s-32vcpu-192gb = 960USD"
# EOT
#   type = string
# }

# variable "do_token" {}

# provider "digitalocean" {
#   token = "${var.do_token}"
# }

provider "aws" {
  region = "us-east-1" # Change to your desired region
  
}
