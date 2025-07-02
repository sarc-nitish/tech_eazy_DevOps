#!/bin/bash

echo "🚀 Starting Web Server..."

# Install Apache HTTPD if not already
sudo yum install -y httpd

# Start the web server
sudo systemctl start httpd
sudo systemctl enable httpd

# Create a simple HTML page
echo "<h1>Deployed from GitHub via AWS CLI 🚀</h1>" | sudo tee /var/www/html/index.html

# ✅ Load S3 config
CONFIG_PATH="./configs/s3_config.json"
if [[ ! -f "$CONFIG_PATH" ]]; then
  echo "❌ Config file not found: $CONFIG_PATH"
  exit 1
fi

CONFIG=$(cat "$CONFIG_PATH")
S3_BUCKET=$(echo "$CONFIG" | jq -r '.bucket_name')
S3_OBJECT=$(echo "$CONFIG" | jq -r '.s3_object')
REGION=$(echo "$CONFIG" | jq -r '.region')

# ✅ Create a log file
LOG_FILE="deployment_log.txt"
echo "Web server deployed successfully at $(date)" > "$LOG_FILE"

# ✅ Upload log to S3
aws s3 cp "$LOG_FILE" "s3://$S3_BUCKET/$S3_OBJECT" --region "$REGION"

echo "✅ Log uploaded to S3"
