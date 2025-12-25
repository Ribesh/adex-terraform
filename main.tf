terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

# Get default VPC and subnet for simplicity
data "aws_vpc" "default" {
    default =   true
}

# Data Source
data "aws_subnets" "default"{
    filter {
        name = "vpc-id"
        values  =   [data.aws_vpc.default.id]
    }
}

# S3 Bucket
resource "aws_s3_bucket" "my_bucket"{
    bucket = "ribesh-adexbootcamp-assignment-1"
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


# EC2 Instance
resource "aws_instance" "my_instance"{
    ami =   "ami-068c0051b15cdb816" # Amazon Linux 2 ==> us-east-1
    instance_type = "t2.micro"
    subnet_id   =   data.aws_subnets.default.ids[0]
    associate_public_ip_address =   true

    tags    =   {
        Name    =   "adexbootcamp"
        Environment =   "dev"
    }
}