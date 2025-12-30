output "instance_id" {
    description =   "EC2 instance id"
    value   =   aws_instance.my_instance.id
}


output "public_ip" {
    description = "Public IP address"
    value   =   aws_instance.my_instance.public_ip
}