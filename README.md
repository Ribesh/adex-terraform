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


2.  Initialize:
    ```bash
    terraform init
    ```

3.  Review plan:
    ```bash
    terraform plan
    ```

4.  Apply:
    ```bash
    terraform apply 
    ```
    > Confirm with `yes`.

5.  Validate:
    ```bash
    aws s3 ls
    
    2025-12-15 20:29:00 cf-templates-z2a2wgp3no8h-us-east-1
    2025-12-25 11:51:33 ribesh-adexbootcamp-assignment-1
    2025-12-15 19:56:49 ribesh-bootcamp-bucket
    ```

    ```bash
    aws ec2 describe-instances --region us-east-1
    ```


6.  Destroy
    ```bash
    terraform destroy
    ```

### State management explanation

1. Terraform keeps a **state file** that maps Terraform resources (`aws_instance.web`, `aws_s3_bucket.secure_bucket`) to real AWS objects (instance IDs, bucket ARNs) so future plans know what already exists and how to change it safely.


2. *By default*, this state is stored locally in `terraform.tfstate`, which is risky for teams and can expose sensitive data.
    ​

3. On each `terraform plan` or `terraform apply`:

    -   Terraform downloads the latest state from `S3`, refreshes it against real AWS resources, computes the diff, applies changes, then writes back the updated state and releases the lock.