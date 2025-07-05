#  TechEazy DevOps Internship Assignments

This repository contains **automated DevOps workflows** using AWS services (EC2, S3, IAM) built as part of the **TechEazy Consulting Internship**.

---

##  Project Structure

```
techeazy_DevOps/
├── README.md
├── run.sh
├── scripts/
│   ├── deploy.sh
│   ├── shutdown_upload.sh
├── configs/
│   ├── dev_config.json
│   ├── s3_config.json
├── iam/
│   ├── create_roles.sh
│   ├── s3_read_policy.json
│   └── s3_upload_policy.json
├── resources/
│   ├── ec2-stopped.png
│   ├── web-output.png
│   └── s3-logs-proof.png
```

---

##  Assignment 1 – EC2 Auto Deployment

###  Objective:

Deploy a basic Apache web server using Bash and AWS CLI on an EC2 instance.

###  Key Actions:

* Reuse or launch EC2 instance
* Install Apache server (httpd)
* Serve HTML from GitHub
* Auto stop the EC2 instance

### ▶ Run:

```bash
cd scripts
chmod +x deploy.sh
./deploy.sh ./configs/dev_config.json
```

🗁 Proof in `resources/`:

####  EC2 Instance Stopped
<img src="resources/ec2-stopped.png" alt="EC2 Stopped" width="400"/>

####  Apache Server Output
<img src="resources/web-output.png" alt="Web Output" width="400"/>

---

##  Assignment 2 – IAM Role + S3 Automation

###  Objective:

Enhance previous task by uploading deployment logs to an S3 bucket using IAM roles.

###  Steps:

#### 1️ Create IAM Roles

```bash
cd iam
chmod +x create_roles.sh
./create_roles.sh
```

Manually attach IAM Role:
Go to **EC2 → Actions → Security → Modify IAM Role → EC2S3UploadProfile**

#### 2️ Deploy & Upload Logs

```bash
cd scripts
chmod +x deploy.sh
./deploy.sh ./configs/dev_config.json
```

* Runs `run.sh` via SSH
* Logs uploaded to bucket defined in `s3_config.json`
* EC2 instance auto-stops

 `resources/` folder:

####  S3 Log Upload Proof
<img src="resources/s3-logs-proof.png" alt="Web Output" width="400"/>

---

##  IAM & S3 Notes

* Ensure S3 bucket exists before running
* IAM role must allow `s3:PutObject`, `s3:ListBucket`
* Use `jq` for parsing JSON in scripts

---

##  Tested On

* Amazon Linux 2023 AMI
* Git Bash on Windows
* AWS CLI v2
* EC2 (t3.micro, Free Tier)

---

##  Sample Configs

### `configs/dev_config.json`

```json
{
  "instance_type": "t3.micro",
  "region": "eu-north-1",
  "ami_id": "ami-xxxxxxxxxxxxxxx",
  "key_name": "techeazy-key",
  "repo_url": "https://github.com/sarc-nitish/tech_eazy_DevOps.git"
}
```

---

##  Final Notes

 Both assignments completed and tested
 Auto-stop and cost-saving handled
 Log successfully pushed to S3
 Follows single-folder structure as per mentor’s guidance

---

> PR raised via `pr` branch → Merged into `main`
> Thank you TechEazy 
