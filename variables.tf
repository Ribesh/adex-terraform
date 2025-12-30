variable "aws_region" {
  description = "AWS region to deploy resources into"
  type        = string
  default     = "us-east-1"
}


# EC2 Inputs
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for EC2 Instance"
  type        = string
  default     = "ami-068c0051b15cdb816"
}


# S3 Inputs
variable "bucket_name" {
  description = "S3 bucket name"
  type        = string
  default     = "ribesh-adexbootcamp-assignment-3"
}
