#!/bin/bash

CONFIG_FILE=$1
CONFIG=$(cat "$CONFIG_FILE")
INSTANCE_TYPE=$(echo "$CONFIG" | jq -r '.instance_type')
AMI_ID=$(echo "$CONFIG" | jq -r '.ami_id')
REGION=$(echo "$CONFIG" | jq -r '.region')
KEY_NAME=$(echo "$CONFIG" | jq -r '.key_name')
REPO_URL=$(echo "$CONFIG" | jq -r '.repo_url')

echo "🔄 Checking for existing instance..."
INSTANCE_ID=$(aws ec2 describe-instances \
  --filters "Name=instance-type,Values=$INSTANCE_TYPE" \
           "Name=image-id,Values=$AMI_ID" \
           "Name=key-name,Values=$KEY_NAME" \
           "Name=instance-state-name,Values=running,stopped" \
  --region "$REGION" \
  --query "Reservations[0].Instances[0].InstanceId" \
  --output text)

if [[ "$INSTANCE_ID" == "None" || -z "$INSTANCE_ID" ]]; then
  echo "📦 No existing instance found. Launching new EC2..."
  INSTANCE_ID=$(aws ec2 run-instances \
    --image-id "$AMI_ID" \
    --count 1 \
    --instance-type "$INSTANCE_TYPE" \
    --key-name "$KEY_NAME" \
    --region "$REGION" \
    --query 'Instances[0].InstanceId' \
    --output text)
else
  STATE=$(aws ec2 describe-instances \
    --instance-ids "$INSTANCE_ID" \
    --region "$REGION" \
    --query 'Reservations[0].Instances[0].State.Name' \
    --output text)

  if [[ "$STATE" == "running" ]]; then
    echo "🛑 Instance is running. Stopping instance: $INSTANCE_ID"
    aws ec2 stop-instances --instance-ids "$INSTANCE_ID" --region "$REGION"
    aws ec2 wait instance-stopped --instance-ids "$INSTANCE_ID" --region "$REGION"
  fi

  echo "♻️ Reusing instance: $INSTANCE_ID"
  aws ec2 start-instances --instance-ids "$INSTANCE_ID" --region "$REGION" > /dev/null
fi

echo "⏳ Waiting for instance to be running..."
aws ec2 wait instance-running --instance-ids "$INSTANCE_ID" --region "$REGION"

PUBLIC_IP=$(aws ec2 describe-instances \
  --instance-ids "$INSTANCE_ID" \
  --region "$REGION" \
  --query 'Reservations[0].Instances[0].PublicIpAddress' \
  --output text)

echo "🌐 Public IP: $PUBLIC_IP"

echo "🔧 Running remote deployment script..."
ssh -o StrictHostKeyChecking=no -i "$HOME/.ssh/$KEY_NAME.pem" ec2-user@$PUBLIC_IP <<EOF
  sudo yum update -y
  sudo yum install git -y
  sudo yum install java-21-amazon-corretto -y
  sudo yum install httpd -y
  rm -rf tech_eazy_DevOps
  git clone $REPO_URL
  cd tech_eazy_DevOps
  chmod +x run.sh
  ./run.sh
EOF

echo "🛑 Stopping EC2 instance: $INSTANCE_ID"
aws ec2 stop-instances --instance-ids "$INSTANCE_ID" --region "$REGION"
echo "✅ Deployment complete. Instance stopped."
