# Walkthrough

## Section 1: Spinning Up An EKS Cluster

- Refer to `suggested-solutions/working-eks/main.tf` to get the correct values for the subnet CIDR ranges.
- Run the usual terraform commands (ie. `terrform init` -> `terraform plan` -> `terraform apply`) to create your EKS cluster.
- If you encounter permission issues when terraform is trying to create the EKS cluster, it is likely that the default config of the aws authenticator used by Terraform is incompatible with your local AWS access setup.
  - If you're using an AWS profile or role assumption instead of directly exporting the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` variables, then do the following:
  
  ```hcl-terraform
  # In the `main.tf` file
  
  ...
  
  module "eks" {
    source                         = "terraform-aws-modules/eks/aws"
    cluster_name                   = local.cluster_name
    cluster_endpoint_public_access = "true"
    
    # If doing role assumption, add this line
    kubeconfig_aws_authenticator_additional_args = [
      "--role-arn",
      "YOUR_ASSUMED_ROLE"
    ]
  
    # If using profile, add this line
    kubeconfig_aws_authenticator_additional_args = [
      "--profile",
      "YOUR_PROFILE_NAME"
    ]
  
    tags = {
      environment = local.cluster_name
    }
  
    vpc_id  = module.vpc.vpc_id
    subnets = module.vpc.private_subnets
  
    worker_groups = [
      {
        autoscaling_enabled  = true
        asg_min_size         = 2
        asg_max_size         = 2
        asg_desired_capacity = 2
        instance_type        = "t3.small"
      }
    ]
  }
  
  ```
  
- If you encounter issues related to hitting certain VPC limit, change your `AWS_REGION` environment variable to another region apart from `ap-southeast-1`.
- To configure `kubectl` to point to the newly created cluster:
  ```
  aws eks --region YOUR-SELECTED-REGION update-kubeconfig --name YOUR-CLUSTER-NAME
  ```
- To check if your nodes are connected and ready:
  ```
  kubectl get nodes
  ```   

## Section 2: Using Helm

1. You can refer to the Helm charts in `suggested-solutions/working-cat-application` and `suggested-solutions/working-meow-application` for the working solutions.
   - Run `helm template cat-application suggested-solutions/working-cat-application` command to see how the rendered Kubernetes config will look like

2. To install a fresh Helm release, run `helm install cat-application suggested-solutions/working-cat-application`. This will install a Helm release named `cat-application` into the Kubernetes namespace you're currently in.
   - Run `helm ls` to see the status of this release. 
   - If you want to update an existing Helm release, run `helm upgrade --atomic --timeout 60 cat-application suggested-solutions/working-cat-application`. The `--atomic` flag ensures that changes are rolled back if the upgrade fails after 60s.
   - To simulate the installation/upgrade, add the `--dry-run` flag to either command.
   
3. To install the Nginx Ingress Controller, run `helm install nginx-ingress stable/nginx-ingress`
   - Run `helm get manifest nginx-ingress` to see what resources were installed for this release.
   - Check the Load Balancer URL that has been provisioned by running `kubectl get service`, and identify the external URL tied to the newly created nginx ingress service.
  
4. The working Ingress resources are already present in the `suggested-solutions/working-cat-application` and `suggested-solutions/working-meow-application` folders. If you've installed these charts earlier, then you would already be able to test the endpoints directly now.
   - Run `curl http://<LOAD_BALANCER_URL>/meow` to see the results 
