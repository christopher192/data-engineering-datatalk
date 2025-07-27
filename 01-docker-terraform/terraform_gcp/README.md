## Terraform
Infrastructure as Code (IaC) tool that lets user define, create, and manage cloud infrastructure using code. Instead of clicking through cloud dashboards, write  the configuration files in .tf format to automate thing such as
- Creating virtual machine
- Setting up storage bucket
- Launching database
- Manage network

In conclusion, the cloud infrastructure become manageable, version-controlled (like source code), reusable and shareable, easier to automate and replicate

### Step-by-Step
1. Allow Terraform to create and manage resources in GCP
    - Go to GCP → IAM & Admin → Service Accounts, then
    - Select or create a Service Account.
    - Under the "Permission" section, grant the following roles.
        - BigQuery Admin
        - Compute Admin
        - Storage Admin
    - Create a private key
        - Format: JSON.
        - Allow Terraform to act on behalf of service account.
    - Download and securely store the JSON key.

This will allow the service account to manage BigQuery, Compute Engine, and Cloud Storage resources as required by Terraform.

2. Install HashiCorp Terraform in VS Code Extension
3. Install Terraform (Ubuntu)
```
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

4. Setting environment variable, tell Google Cloud SDKs and Terraform where to find service account private key
```
export GOOGLE_APPLICATION_CREDENTIALS="$(pwd)/yourkey.json"
```

5. Terraform Execution
```
# authenticate for current session (recommended)
gcloud auth application-default login

# initialize state file (.tfstate)
terraform init

# check changes to new infra plan
terraform plan -var="project=<your-gcp-project-id>"

# create new infra
terraform apply -var="project=<your-gcp-project-id>"

# delete infra after work, to avoid cost on any running services
terraform destroy
```