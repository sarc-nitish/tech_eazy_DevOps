#!/bin/bash

echo "🚀 Starting App..."

# Example: Start HTTP server (port 80)
sudo yum install -y httpd
sudo systemctl start httpd
sudo systemctl enable httpd

echo "<h1>Deployed from GitHub via AWS CLI 🚀</h1>" | sudo tee /var/www/html/index.html
