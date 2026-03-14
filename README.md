 DevOps Challenge 3 — Terraform + Ansible on AWS

 Overview  
This project provisions AWS infrastructure using terraform and configures an EC2 instance using Ansible. The EC2 instance hosts a simple web page displaying “Hello, World!”.  

The challenge demonstrates the ability to automate cloud infrastructure, manage configuration, and deploy a working application using modern DevOps tooling.

---

 Tools & Environment Setup

WSL / Ubuntu Setu
The project was developed using Ubuntu on WSL.  
Initial setup included:

- Updating and upgrading Ubuntu packages  
- Confirming installation of:
  - Git  
  - Ansible  
  - Terraform  
  - AWS CLI  

SSH Keys
A local SSH key pair was created and stored securely on the developer’s machine.  
This key pair was not generated in the AWS console for security reasons—local keys cannot be viewed or modified by anyone with AWS console access.

To view available keys:

```bash
ls ~/.ssh
```

The public key path was added to Terraform variables so it could be injected into the EC2 instance at creation time.

---

 Terraform Infrastructure

Terraform provisions the following AWS resources:

- EC2 instance (Ubuntu 22.04)
- S3 bucket
- IAM roles and policies
- Security groups (allowing SSH + HTTP)

Dynamic AMI Lookup
Instead of hard‑coding an AMI ID, Terraform dynamically retrieves the latest Ubuntu AMI published by Canonical:

```hcl
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical (Ubuntu)
}
```

This ensures the EC2 instance always uses a valid, up‑to‑date AMI.

---

 Ansible Configuration

Ansible was used to configure the EC2 instance after provisioning

Ansible Tasks
- Install a web server (Nginx or Apache)
- Deploy a simple HTML page containing **“Hello, World!”**
- Ensure the service is running and enabled

Ansible Files
- playbook.yml
- inventory.ini

Ansible was executed from WSL, using the private key stored locally.

---

 Deployment Instructions

1. Deploy Infrastructure with Terraform**

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

Terraform outputs the EC2 public IP address.

---

2. Configure the EC2 Instance with Ansible

Update the inventory file with the EC2 public IP:

```
[web]
<EC2_PUBLIC_IP> ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/<your-key>
```

Run the playbook:

```bash
cd ansible
ansible-playbook playbook.yml
```

---

3. Verify the Web Page

Visit:

```
http://<EC2_PUBLIC_IP>
```

You should see:

```
Hello, World!
```

---

 Version Control & GitHub

- All code was committed and pushed to a private GitHub repository.
- The public SSH key was added to GitHub and to WSL to enable secure communication.
- A README file was added to document setup and usage.

---

 Summary of Learning

This challenge reinforced:

- How to automate AWS provisioning with Terraform  
- How to dynamically fetch AMIs to avoid expiration issues  
- How to securely manage SSH keys outside the AWS console  
- How to configure servers using Ansible  
- How to run Ansible from WSL and connect to cloud resources  
- The importance of separating provisioning (Terraform) from configuration (Ansible)


