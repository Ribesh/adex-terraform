# Introduce `Modules` on your existing Terraform stack with `Variables` and `Outputs`. You might need to create a new branch from the previous branch (not source/main branch)


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

2. Create the modules and root-modules

3.  In the root folder containeing `main.tf` Initialize:
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
    2025-12-30 22:24:47 ribesh-adexbootcamp-assignment-3
    2025-12-15 19:56:49 ribesh-bootcamp-bucket
    ```

    ```bash
    aws ec2 describe-instances --region us-east-1
    ```


7.  Destroy
    ```bash
    terraform destroy
    ```

8.  Output
    ```bash
    Outputs:

    ec2_instance_id = "i-01dd23156adb5b711"
    ec2_public_ip = "3.85.136.86"
    s3_bucket_arn = "arn:aws:s3:::ribesh-adexbootcamp-assignment-3"
    s3_bucket_name = "ribesh-adexbootcamp-assignment-3"
    ```

### State management explanation

1. Terraform keeps a **state file** that maps Terraform resources (`aws_instance.web`, `aws_s3_bucket.secure_bucket`) to real AWS objects (instance IDs, bucket ARNs) so future plans know what already exists and how to change it safely.


2. *By default*, this state is stored locally in `terraform.tfstate`, which is risky for teams and can expose sensitive data.
    ​

3. On each `terraform plan` or `terraform apply`:

    -   Terraform downloads the latest state from `S3`, refreshes it against real AWS resources, computes the diff, applies changes, then writes back the updated state and releases the lock.