terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

################
#Variables 
################

variable "aws_region"{
    description =   "AWS region to deploy resources into"
    type =  string
    default =   "us-east-1"
}

variable "instance_type"{
    description =   "EC2 instance type"
    type    =   string
    default =   "t2.micro" 
}

variable    "ami_id"{
    description     =   "AMI ID for EC2 Instance"
    type    =   string
    default =   "ami-068c0051b15cdb816"
}

variable "bucket_name"{
    description =   "S3 bucket name"
    type    =   string
    default =   "ribesh-adexbootcamp-assignment-1"
}

##################
# Provider
##################

provider "aws"{
    region  =   var.aws_region
}

#################
# Data Sources
#################

data "aws_vpc" "default" {
    default =   true
}


data "aws_subnets" "default"{
    filter {
        name = "vpc-id"
        values  =   [data.aws_vpc.default.id]
    }
}

###############
# S3 Bucket
###############

resource "aws_s3_bucket" "my_bucket"{
    bucket = "ribesh-adexbootcamp-assignment-2"
    tags =  {
        Name    =   "adexbootcamp"
        Environment =   "dev"
    }
}

resource "aws_s3_bucket_public_access_block" "my_bucket_block"{
    bucket  =   aws_s3_bucket.my_bucket.id

    block_public_acls   =   true
    block_public_policy =   true
    ignore_public_acls  =   true
    restrict_public_buckets =   true
}

##################
# EC2 Instance
##################

resource "aws_instance" "my_instance"{
    ami =   var.ami_id
    instance_type = var.instance_type
    subnet_id   =   data.aws_subnets.default.ids[0]
    associate_public_ip_address =   true

    tags    =   {
        Name    =   "adexbootcamp"
        Environment =   "dev"
    }
}

#############
# Output
#############

output "s3_bucket_name"{
    description =   "Name of the S3 bucket"
    value  = aws_s3_bucket.my_bucket.bucket  
}


output  "s3_bucket_arn"{
    description =   "ARN of the S3 Bucket"
    value   =   aws_s3_bucket.my_bucket.arn
}


output  "ec2_intance_id" {
    description =   "ID of the EC2 intance"
    value   =   aws_instance.my_instance.id
}

output  "ec2_public_ip" {
    description =   "Public IP of the EC2 Intance"
    value   =   aws_instance.my_instance.public_ip
}