#!/bin/bash

S3_BUCKET_NAME="deens3backend"


# Create S3 bucket with region configuration

Echo "Creating S3 bucket: $S3_BUCKET_NAME ..."
aws s3api create-bucket \
  --bucket $S3_BUCKET_NAME \
  --region us-west-1 \
  --create-bucket-configuration LocationConstraint=us-west-1


#Create key pair for EC2 instance

Echo "Creating key pair for EC2 instance..."
aws ec2 create-key-pair \
  --key-name main-ec2 \
  --region us-west-1 \
  --query "KeyMaterial" \
  --output text > main-ec2.pem



# Set permissions for the key pair file  

Echo "Setting permissions for main-ec2.pem ..."
chmod 400 main-ec2.pem

# Apply Terraform configuration to create infrastructure
Echo "Applying Terraform configuration to create infrastructure..."
terraform apply -auto-approve
