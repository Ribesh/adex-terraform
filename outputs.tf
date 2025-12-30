output "s3_bucket_name" {
    description =   "Created bucket name"
    value   =   module.s3.bucket_name
}

output "s3_bucket_arn" {
    description =   "Created bucket ARN"
    value   =  module.s3.bucket_arn
}

output "ec2_instance_id" {
    description =   "EC2 instance ID"
    value   =   module.ec2.instance_id
}

output "ec2_public_ip" {
    description =   "EC2 Public IP"
    value   = module.ec2.public_ip
}