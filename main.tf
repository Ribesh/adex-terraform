module "s3" {
    source = "./modules/s3"
    bucket_name =   var.bucket_name

    tags    =   {
        Name    =   "adexbootcamp"
        Environment =   "dev"
    }
}

module "ec2" {
    source = "./modules/EC2"
    ami_id  =   var.ami_id
    instance_type   =   var.instance_type
    subnet_id   =   data.aws_subnets.default.ids[0]
    associate_public_ip_address =   true
    
    tags    =   {
        Name    =   "adexbootcamp"
        Environment =   "dev"
    }

}