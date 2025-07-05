# TechEazy DevOps Internship Assignments

Welcome to my DevOps Internship Project Repository for **TechEazy Consulting**.

This repository contains two major assignments completed during the internship, showcasing automation using **AWS CLI**, **EC2**, **S3**, **IAM**, and shell scripting.

---

## Repository Structure

```
tech_eazy_DevOps/
├── README.md               
├── assignment_1/           ← EC2 Auto Deployment
│   ├── run.sh
│   ├── README.md
│   ├── scripts/
│   └── resources/
│       ├── ec2-stopped.png
│       └── web-output.png
│
└── assignment_2/           ← EC2 + IAM + S3 Automation
    ├── run.sh
    ├── README.md
    ├── configs/
    ├── iam/
    ├── scripts/
    └── resources/
        ├── ec2-stopped.png
        ├── web-output.png
        └── s3-logs-proof.png
```

---

## Assignment 1 – EC2 Auto Deployment (Basic)

- Launch EC2 using `deploy.sh`
- Install Apache server (`httpd`)
- Display webpage with confirmation
- Auto stop EC2 after task
- Screenshots captured in `resources/`

 Go to: [assignment_1/](./assignment_1)

---

## Assignment 2 – IAM & S3 Log Upload (Advanced)

- Create IAM Roles (Upload + Read)
- Attach instance profile to EC2
- Upload deployment logs to private S3 bucket
- Auto stop EC2
- Full lifecycle implemented via Bash

 Go to: [assignment_2/](./assignment_2)

---

##  Technologies Used

- AWS EC2, IAM, S3
- Amazon Linux 2023
- Bash scripting
- AWS CLI v2
- Git & GitHub

---
"Testing Pull Request from master branch"
## PR Submission

✅ All tasks tested with real EC2 instances  
✅ Logs uploaded successfully to S3  
✅ Folder structure clean and documented  
✅ Pull Request raised via `pr` branch 

"Testing Pull Request from master branch"
🟢 Final restructuring PR submission
