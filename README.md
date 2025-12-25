# Transform EC2 and S3 CloudFormation Templates into Terraform code

-   `EC2` and `S3 (Secure)` have already been written in CFT in the previous classes.

-   Rewrite them in `Terraform` using only `Providers`, `Resources` and `Data Sources` in one `main.tf` file if possible.

-   Launch the resources written in `Terraform` to validate your code.

-   Document your process and also include State Management explanation in your process.


## Steps

1.  Firstly, Configure AWS Credentials:
    ```bash
    aws configure
    
    AWS Access Key ID [****************XOPW]: 
    AWS Secret Access Key [****************ioG6]: 
    AWS Session Token [****************8A==]: 
    Default region name [None]: 
    Default output format [None]: 
    ```

2. Create `main.tf` file
    ```bash
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
    ```

3.  Initialize:
    ```bash
    terraform init
    ```

4.  Review plan:
    ```bash
    terraform plan
    ```

5.  Apply:
    ```bash
    terraform apply 
    ```
    > Confirm with `yes`.

6.  Validate:
    ```bash
    aws s3 ls
    
    2025-12-15 20:29:00 cf-templates-z2a2wgp3no8h-us-east-1
    2025-12-25 11:51:33 ribesh-adexbootcamp-assignment-1
    2025-12-15 19:56:49 ribesh-bootcamp-bucket
    ```

    ```bash
    aws ec2 describe-instances --region us-east-1
    ```


7.  Destroy
    ```bash
    terraform destroy
    ```

### State management explanation

1. Terraform keeps a **state file** that maps Terraform resources (`aws_instance.web`, `aws_s3_bucket.secure_bucket`) to real AWS objects (instance IDs, bucket ARNs) so future plans know what already exists and how to change it safely.


2. *By default*, this state is stored locally in `terraform.tfstate`, which is risky for teams and can expose sensitive data.
    ​

3. On each `terraform plan` or `terraform apply`:

    -   Terraform downloads the latest state from `S3`, refreshes it against real AWS resources, computes the diff, applies changes, then writes back the updated state and releases the lock.