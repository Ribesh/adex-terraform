variable "ami_id" {
    description = "AMI ID for the instance"
    type    =   string
}

variable "instance_type" {
    description =   "EC2 instance type"
    type    =   string
}

variable "subnet_id" {
  description = "Subnet ID where instance will be launched"
  type        = string
}

variable "associate_public_ip_address" {
  description = "Whether to associate a public IP address"
  type        = bool
  default     = true
}


variable "tags" {
    description = "Tags to apply to resources"
    type    =   map(string)
    default =   {}
}