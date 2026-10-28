#!/bin/bash

# Delete Terraform-managed infrastructure
Echo "Deleting Terraform-managed infrastructure..."
terraform destroy -auto-approve

# Delete EC2 key pair
Echo "Deleting EC2 key pair..."
aws ec2 delete-key-pair \
  --key-name main-ec2 \
  --region us-west-1

# Remove local key pair file
chmod 700 main-ec2.pem
rm main-ec2.pem

S3_BUCKET_NAME="deens3backend"


# Delete all objects from S3 bucket before deleting the bucket itself
Echo "Deleting all objects from S3 bucket: $S3_BUCKET_NAME ..."

aws s3 rm s3://$S3_BUCKET_NAME --recursive


# delete S3 bucket
Echo "Deleting S3 bucket: $S3_BUCKET_NAME ..."
aws s3api delete-bucket \
  --bucket $S3_BUCKET_NAME \
  --region us-west-1