cd ~/w3-combo

cat > README.md << 'EOF'
# W3 Combo – The Forbidden Path  
### DevOps Automation with Terraform + Ansible + AWS

This project demonstrates fully automated provisioning, configuration, and load balancing of AWS EC2 instances using:

✅ Terraform (Infrastructure as Code)  
✅ Ansible (Configuration as Code)  
✅ Bash scripting (Single-command automation)  
✅ Dynamic inventory based on Terraform output  

---

## 🚀 Achievements (Milestones)

| Milestone | Description | Automation |
|----------|-------------|------------|
| ✅ M1 | 1 EC2 instance with Nginx installed | Terraform + Ansible + script |
| ✅ M2 | 3 EC2 app servers each with unique HTML page | Template-based Ansible |
| ✅ M3 | Load balancer instance → Round-robins to app servers | Host groups + Nginx upstream |

One command (`./scripts/all-in-one.sh 1|2|3`) performs **complete deployment**.

`destroy.sh` fully tears down resources ✅  
→ Prevents AWS charges

---

## 🧱 Architecture Diagram  
*(Milestone 3)*

┌──────────────────┐
│ User’s Browser │
└───────┬──────────┘
│ HTTP 80
┌───────▼─────────────────────────┐
│ EC2 - Load Balancer (Nginx) │
│ Group: [lb] │
└───┬───────────┬───────────┬────┘
│ │ │
▼ ▼ ▼
┌────────┐ ┌────────┐ ┌────────┐
│ App #1 │ │ App #2 │ │ App #3 │
│ Group: │ │ [app] │ │ │
│[app] │ │ │ │ │
└────────┘ └────────┘ └────────┘

---

## 📸 Screenshots

### ✅ Milestone 1 – Proof of success
![Milestone1](screenshots/Screenshot%202025-10-28%20at%2019.35.29.png)

### ✅ Milestone 2 – Three App Servers
| App1 | App2 | App3 |
|------|------|------|
| ![](screenshots/Screenshot%202025-10-28%20at%2019.41.12.png) | ![](screenshots/Screenshot%202025-10-28%20at%2019.42.20.png) | ![](screenshots/Screenshot%202025-10-28%20at%2019.42.30.png) |

---

## 💻 Requirements (macOS)

| Tool | Version | Command |
|------|---------|---------|
| Terraform | ≥ 1.6 | `brew install terraform` |
| Ansible | ≥ 2.14 | `brew install ansible` |
| AWS CLI | Configured | `aws configure` |
| JQ | Installed | `brew install jq` |

AWS key pair **must exist** in AWS → same region as EC2 ✅

---

## ▶️ Deployment / Usage

### Milestone 1 – One App Server

```bash
./scripts/all-in-one.sh 1
Milestone 2 – Three App Servers
./scripts/all-in-one.sh 2
Milestone 3 – Load Balancer + Three App Servers
./scripts/all-in-one.sh 3
Script prints public IP(s) automatically ✅
Visit them in browser and refresh for load balancing behavior ✅
💣 Cleanup (stop paying AWS!)
Always destroy resources after testing:
./scripts/destroy.sh
📂 Project Structure
w3-combo/
├── terraform/        # IaC provisioning
├── ansible/          # Playbooks, templates, dynamic inventory
├── scripts/          # Single-command automation
└── screenshots/      # Deployment proof
✍️ Author
Fotios Pongas
GitHub: https://github.com/Kabamaru2372
✅ Status
✅ 100% Completed
✅ AWS + Automation working
✅ Submission-ready
