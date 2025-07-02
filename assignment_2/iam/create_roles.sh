

#!/bin/bash

# Role A
aws iam create-role --role-name S3ReadOnlyRole --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": { "Service": "ec2.amazonaws.com" },
    "Action": "sts:AssumeRole"
  }]
}'

aws iam put-role-policy \
  --role-name S3ReadOnlyRole \
  --policy-name S3ReadPolicy \
  --policy-document file://s3_read_policy.json


# Role B
aws iam create-role --role-name S3UploadRole --assume-role-policy-document '{
  "Version": "2012-10-17",
  "Statement": [{
    "Effect": "Allow",
    "Principal": { "Service": "ec2.amazonaws.com" },
    "Action": "sts:AssumeRole"
  }]
}'

aws iam put-role-policy \
  --role-name S3UploadRole \
  --policy-name S3UploadPolicy \
  --policy-document file://s3_upload_policy.json


# Instance Profile
aws iam create-instance-profile --instance-profile-name EC2S3UploadProfile

aws iam add-role-to-instance-profile \
  --instance-profile-name EC2S3UploadProfile \
  --role-name S3UploadRole

echo "✅ Roles and Instance Profile created"
