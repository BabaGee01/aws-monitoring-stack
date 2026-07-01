# AWS Monitoring Stack

![Terraform](https://img.shields.io/badge/Terraform-1.5+-623CE4?logo=terraform)
![AWS](https://img.shields.io/badge/AWS-EC2%20%7C%20CloudWatch%20%7C%20SNS-FF9900?logo=amazon-aws)
![Prometheus](https://img.shields.io/badge/Prometheus-2.49-E6522C?logo=prometheus)
![Grafana](https://img.shields.io/badge/Grafana-10.3-F46800?logo=grafana)
![License](https://img.shields.io/badge/License-MIT-green)

A production-style cloud infrastructure monitoring platform provisioned entirely with Terraform on AWS. Demonstrates end-to-end observability using Prometheus, Grafana, Node Exporter, and CloudWatch with automated alerting via SNS.

## What It Does

- Provisions a full AWS environment (VPC, subnets, IGW, security groups, EC2) using modular Terraform
- Deploys Prometheus and Node Exporter to collect system metrics (CPU, memory, disk, network)
- Visualises live metrics in Grafana using the Node Exporter Full dashboard (ID 1860)
- Configures CloudWatch alarms with SNS email notifications for CPU threshold breaches
- All infrastructure managed as code — reproducible, version-controlled, and destroyable in one command

## Architecture

![Architecture Diagram](docs/aws_monitoring_stack_architecture.png)

## Tech Stack

| Tool | Purpose |
|---|---|
| Terraform | Infrastructure provisioning (VPC, EC2, CloudWatch, SNS) |
| AWS EC2 | Hosts the monitoring stack |
| Prometheus | Metrics collection and storage |
| Node Exporter | Exposes EC2 system metrics to Prometheus |
| Grafana | Metrics visualisation and dashboards |
| CloudWatch | AWS-native monitoring and alarm management |
| SNS | Email alerting on threshold breaches |

## Screenshots

### Grafana — Node Exporter Full Dashboard (Live Metrics)
![Grafana Dashboard](docs/grafana-dashboard.png)

### Grafana — CPU Spike During Stress Test
![CPU Spike](docs/grafana-cpu-spike.png)

### CloudWatch — CPU Utilisation Alarm
![CloudWatch Alarm](docs/cloudwatch-alarm.png)

## Prerequisites

- AWS account with IAM user (programmatic access)
- Terraform >= 1.5
- AWS CLI configured (`aws configure`)
- An EC2 key pair created in eu-west-2

## Quick Start

```bash
# Clone the repo
git clone https://github.com/yourusername/aws-monitoring-stack.git
cd aws-monitoring-stack/terraform

# Initialise Terraform
terraform init

# Update terraform.tfvars with your values
# ami_id, key_name, my_ip, alert_email

# Preview changes
terraform plan

# Deploy
terraform apply
```

Access your stack:
- Prometheus: `http://<EC2_PUBLIC_IP>:9090`
- Grafana: `http://<EC2_PUBLIC_IP>:3000` (default: admin/admin)

## Project Structure

```
aws_monitoring_stack/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars        # Not committed — add your values
│   └── modules/
│       ├── vpc/                # VPC, subnet, IGW, route tables
│       ├── ec2/                # EC2 instance, security group, userdata
│       └── cloudwatch/         # Alarms, SNS topic, dashboard
├── docs/                       # Architecture diagram and screenshots
└── README.md
```

## Cleanup

Destroy all resources to avoid AWS charges:

```bash
cd terraform
terraform destroy
```

## Author

Jide Oloko — [LinkedIn](https://www.linkedin.com/in/jide-oloko-2a4bb588) | [Medium](https://medium.com/@sb.oloko) | [Project Portfolio](https://babagee01.github.io/)
