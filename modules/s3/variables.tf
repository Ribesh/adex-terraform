variable "bucket_name" {
    description =   "Name of S3 Bucket"
    type    =   string
}


variable "tags" {
    description =   "Tags to apply to resources"
    type    =   map(string)
    default =   {}
}