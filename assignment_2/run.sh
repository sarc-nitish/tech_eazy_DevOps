#!/bin/bash

echo "🚀 Starting Web Server..."
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

echo "<h1>Deployed from GitHub via AWS CLI 🚀</h1>" | sudo tee /var/www/html/index.html


# Trigger upload logs (shutdown)
sudo chmod +x scripts/shutdown_upload.sh
scripts/shutdown_upload.sh

CONFIG_PATH="./configs/s3_config.json"

