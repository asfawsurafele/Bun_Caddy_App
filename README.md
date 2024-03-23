## Bun Caddy App Setup Guide

**Description:** This guide provides step-by-step instructions for setting up the Bun Caddy App, which utilizes the Caddy web server and the Bun package manager. The application is generated using Terraform and Ansible and hosted on AWS.

### Initialization Steps

1. **Terraform Setup:**
   ```bash
   cd terraform
   terraform init
   terraform plan -out app
   terraform apply app

2. **Ansible Setup:**
    ```bash
   cd ../ansible
   ansible-playbook playbook.yml -i inventory/inventory.ini -u ubuntu --private-key=../terraform/acit4640_as2.pem



3. **Access the Website:**

Open your web browser.
Enter the DNS of the instances in the address bar.
Press Enter.
Enjoy Your Website!

Explore and enjoy the functionality of your deployed website.