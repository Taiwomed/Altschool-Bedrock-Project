# Altschool-Bedrock-Project
Deploying a Retail App on AWS EKS with ALB Integration
This project details the complete deployment of a containerized retail application to Amazon EKS using Terraform for infrastructure automation. It also integrates AWS’s Application Load Balancer (ALB) for secure external access.
You can visit the live store at: lara-store.site

🔧 Key Components of the Project
1. Infrastructure Setup with Terraform
The infrastructure was built using a file-per-resource approach (not modules), improving clarity and maintainability.
Key Terraform files:
```vpc.tf: Defines the VPC and its CIDR block and Creates public/private subnets across availability zones.
```eks.tf: Provisions the EKS cluster and node groups.
```providers.tf: Declares the AWS provider.
locals.tf: Stores reusable variables and naming conventions.
versions.tf: Defines the versions for the different providers used
output.tf: This outputs some information about the cluster created and the vpc.

2. EKS Cluster Configuration
The cluster was defined in eks.tf.
It includes:
Auto-scaling worker node groups.
IAM roles and policies for both EKS and nodes.
Security groups for Kubernetes communication.
After provisioning, the local kubeconfig was updated using:
 aws eks update-kubeconfig --name <cluster-name> --region <region>


3. Application Deployment
The retail app includes a frontend UI and backend API, both containerized and deployed to EKS.
Kubernetes resources:
Namespace: retail-dev
Deployments: Separate for UI and API
Services: Internal communication via ClusterIP
4. Ingress Setup with ALB
AWS Load Balancer Controller was installed to manage ingress.
Ingress resource was configured to:
Use an internet-facing ALB
Listen on ports 80 (HTTP) and 443 (HTTPS)
Attach an SSL certificate from ACM
Define health check paths (/health)
Example annotations:
 kubernetes.io/ingress.class: alb
alb.ingress.kubernetes.io/scheme: internet-facing
alb.ingress.kubernetes.io/listen-ports: '[{"HTTP":80},{"HTTPS":443}]'
alb.ingress.kubernetes.io/target-type: ip
alb.ingress.kubernetes.io/certificate-arn: <certificate-arn>


5. SSL with AWS Certificate Manager
A certificate for store.mijanscript.xyz was issued via ACM.
DNS validation was completed using CNAME records in Namecheap.
Once validated, the certificate was linked to the ALB for HTTPS access.
6. DNS Configuration via Namecheap
Instead of Route 53, Namecheap was used for DNS.
An A record was created pointing to the ALB’s DNS name.
DNS propagation enabled access over both HTTP and HTTPS.
7. CI/CD with GitHub Actions
A GitHub Actions workflow automates Terraform tasks:
On feature branch push:
terraform fmt for formatting
terraform validate for syntax
terraform plan to preview changes
On merge to main:
terraform apply to deploy infrastructure
This ensures consistent, automated deployments with clean code.
8. Troubleshooting Highlights
Ingress 404s: Fixed by correcting service mappings and ALB reconciliation.
DNS issues: Resolved by verifying Namecheap records and propagation.
HTTPS failures: Solved by updating ALB security group to allow port 443.

👤 IAM User Access & RBAC Integration
An IAM user was created and integrated with the EKS cluster using Kubernetes RBAC.
The user was granted read-only permissions to list and describe cluster resources.
Setup steps:
Create IAM user and access keys.
On the user’s machine:
 aws configure --profile dev-readonly


Region: eu-west-2
Output: json
Update kubeconfig:
 aws eks update-kubeconfig \
  --region eu-west-2 \
  --name your-cluster-name \
  --profile dev-readonly \
  --alias dev-readonly


Test access:
 kubectl get pods
kubectl get pods --namespace retail-dev



✅ Conclusion
This project successfully demonstrates:
Infrastructure as Code using Terraform
Secure, scalable app hosting on EKS
CI/CD automation with GitHub Actions
DNS and SSL integration using Namecheap and ACM
Fine-grained access control via IAM and Kubernetes RBAC
It’s production-ready and extensible for scaling, monitoring, and further automation.
