#!/bin/bash

# Load config
CONFIG_FILE=$1
if [ -z "$CONFIG_FILE" ]; then
  echo "Usage: ./deploy.sh dev_config.json"
  exit 1
fi

CONFIG=$(cat $CONFIG_FILE)
INSTANCE_TYPE=$(echo $CONFIG | jq -r '.instance_type')
AMI_ID=$(echo $CONFIG | jq -r '.ami_id')
REGION=$(echo $CONFIG | jq -r '.region')
KEY_NAME=$(echo $CONFIG | jq -r '.key_name')
REPO_URL=$(echo $CONFIG | jq -r '.repo_url')

# Step 1: Launch EC2
echo "Launching EC2..."
INSTANCE_ID=$(aws ec2 run-instances \
  --image-id $AMI_ID \
  --instance-type $INSTANCE_TYPE \
  --key-name $KEY_NAME \
  --region $REGION \
  --security-groups default \
  --query 'Instances[0].InstanceId' \
  --output text)

echo "Instance launched: $INSTANCE_ID"

# Wait for running
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# Get public IP
PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids $INSTANCE_ID \
  --region $REGION \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "Public IP: $PUBLIC_IP"

# SSH into EC2 and deploy app
ssh -o StrictHostKeyChecking=no -i "~/.ssh/$KEY_NAME.pem" ec2-user@$PUBLIC_IP << EOF
  sudo yum update -y
  sudo yum install git java-21-amazon-corretto -y
  git clone $REPO_URL
  cd techeazy-devops
  chmod +x run.sh
  ./run.sh
EOF

# Stop EC2 after 2 hrs
aws ec2 stop-instances --instance-ids $INSTANCE_ID --region $REGION
