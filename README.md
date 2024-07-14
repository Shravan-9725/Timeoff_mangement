Installation and Deployment on AWS EKS

Prerequisites:

. AWS account with appropriate permissions

. Kubernetes command-line tool (kubectl) configured

. AWS CLI Installed

. AWS account with ECR(Elastic Container Registry) and EKS (Elastic Kubernetes Engine). 

. Docker installed locally to build and push Docker images

Deploying TimeOff.Management to AWS EKS:

. Clone the Repository

. git clone https://github.com/timeoff-management/application.git timeoff-management

. cd timeoff-management

Build, TAG, and PUSH Image to ECR

. docker build -t timeoff-management .

(Note: Replace YOUR_ECR_REPO_URI with your actual ECR repository URI.)

. aws ecr get-login-password --region your-aws-region | docker login --username AWS --password-stdin YOUR_ECR_REPO_URI

. docker tag timeoff-management:latest YOUR_ECR_REPO_URI:latest

. docker push YOUR_ECR_REPO_URI:latest


Create EKS Cluster:

Use eksctl to create an EKS cluster. Replace YOUR_CLUSTER_NAME and adjust configurations as needed.

. eksctl create cluster --name YOUR_CLUSTER_NAME --version 1.21 --region your-aws-region --nodegroup-name standard-workers --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 4 --managed

Connect EKS cluster tou your local machine:

. aws eks --region <region> update-kubeconfig --name <cluster-name>

Deploy Application to EKS:

. Use Kubernetes manifests (deployment.yaml, service.yaml, etc.) adapted for your AWS setup. Ensure to substitute placeholders like YOUR_ECR_REPO_URI with actual values.

. HELM Chart can also be used which will contain all the manifest files.

. kubectl apply -f <manifest_file_name>

Incase of helm chart use the following commands:

To create helm chart,

. helm create <chart_name>

To install helm:

. helm install <release_name> <chart_name>

Access the Application:

After successful deployment, access the application using the load balancer URL provided by AWS EKS. Ensure security groups and ingress rules allow access.


![Screenshot (129)](https://github.com/user-attachments/assets/3fe00be1-d75c-4895-a6eb-abd664cdcebb)

![Screenshot (130)](https://github.com/user-attachments/assets/4bb3e64b-d3b9-4a15-a2ff-6792806cc06d)

