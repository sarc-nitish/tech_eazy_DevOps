# TechEazy DevOps Assignment 🚀

This repo contains an automated deployment script that:
- Launches an EC2 instance
- Installs Java + Git
- Clones a GitHub repo
- Runs a backend app
- Stops the instance after 2 hours

## 🛠 How to Use

```bash
cd scripts
chmod +x deploy.sh
./deploy.sh dev_config.json
