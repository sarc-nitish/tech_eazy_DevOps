# Assignment 1 - EC2 Auto Deployment with Apache Web Server

##  Objective

Automate the provisioning of an EC2 instance and deploy a basic web server that serves an HTML response using a Bash script and AWS CLI.

---

##  Tech Stack

* **AWS EC2**
* **Amazon Linux 2023**
* **AWS CLI**
* **Bash Script**
* **Git**
* **Apache HTTPD**

---

##  Folder Structure

```
assignment_1/
├── README.md                 
├── run.sh                     <- Starts Apache server and shows success message
├── resources/                 <- Screenshots for proof
│   ├── ec2-stopped.png
│   ├── web-output.png
├── scripts/
│   ├── deploy.sh              <- Bash script to launch EC2, deploy code, stop EC2
│   └── dev_config.json        <- Configuration for EC2 instance (instance_type, region, key_name, etc.)
```

---

##  Execution Flow

1. `deploy.sh` runs via Bash from local system
2. Checks if a stopped EC2 instance exists

   * If **yes**, it starts and reuses it
   * If **no**, it launches a new one
3. SSH into EC2, installs Apache & deploys HTML message
4. Shuts down the EC2 instance automatically

---

##  How to Run

Make sure:

* AWS CLI is configured (`aws configure`)
* Your `.pem` key is in `~/.ssh/`

```bash
cd assignment_1/scripts
chmod +x deploy.sh
./deploy.sh ../scripts/dev_config.json
```

---

##  Proof (Inside `resources/` folder)

* `web-output.png`: Webpage deployed from EC2 with Apache
* `ec2-stopped.png`: Shows EC2 instance stopped after deployment

---

##  dev\_config.json Sample

```json
{
  "instance_type": "t3.micro",
  "region": "eu-north-1",
  "ami_id": "ami-0c406d4a4a22634fd",
  "key_name": "techeazy-key",
  "repo_url": "https://github.com/sarc-nitish/tech_eazy_DevOps.git"
}
```

---

##  Features

* Reuse stopped EC2 instance
* Fully automated: launch → deploy → stop
* Serverless cost-saving: instance shuts down post-deployment

---

##  Tested On

* Git Bash on Windows 10
* Amazon Linux 2023 AMI
* AWS Free Tier (t3.micro)

---

##  Output Sample

Webpage displays:

```
<h1>Deployed from GitHub via AWS CLI 🚀</h1>
```

---

##  End

This project showcases basic automation using AWS CLI and Bash scripting. Great for beginner-level DevOps practice.

---
