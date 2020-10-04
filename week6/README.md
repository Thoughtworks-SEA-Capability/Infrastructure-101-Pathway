# Week 6: Kubernetes on Cloud and Helm


## What will I learn?
- How to create an EKS cluster using Terraform using IaC
- How to expose cluster applications to the internet
- Use Helm 2 to templatize K8S config files for reusability across environments
- Use Helm 2 to manage multiple deployments in your cluster
- How to use third party Helm charts

## What should I learn on weekend?

### EKS and Kubernetes
- [[Video] Introduction to EKS](https://www.youtube.com/watch?v=gq3pxanOvEk) - Just enough information you need for this Guild session (**3 mins**)
- [EKS Terraform Module](https://github.com/terraform-aws-modules/terraform-aws-eks) - Read about what it is and its basic usage (**5 mins**)
- [[Video] Creating an EKS cluster using Terraform (without module)](https://youtu.be/PjxJzyP_bdU?t=762) (**watch from 12:47 ~ 21:10**)
- [How Client-Side Authentication for EKS works](https://itnext.io/how-does-client-authentication-work-on-amazon-eks-c4f2b90d943b#609a) (**~10 mins**)
- [[Recap] K8S Services Explained with Diagrams](https://medium.com/swlh/kubernetes-services-simply-visually-explained-2d84e58d70e5) (**~10 mins**)
- [[Video] K8S Ingress Explained for Beginners](https://www.youtube.com/watch?v=VicH6KojwCI) (**23 mins**)
- [K8S Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) - Official Documentation on what Ingress is
- [Basic Host Based Routing with NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/) (**5 mins**)
- [**OPTIONAL** [Video] Thorough Overview of EKS](https://www.youtube.com/watch?v=tNlbcBrx_s8) (**40 mins**)
- [**OPTIONAL** How NGINX Ingress Controller Works](https://kubernetes.github.io/ingress-nginx/how-it-works/)
  

### Helm

Note: In this lesson, we're using **Helm 3**. When researching for extra materials or guides online, make sure that the materials are applicable for Helm 3! 

- **[IMPORTANT]** Helm Basics
  - [[Video] What is Helm, Why we need it, How to use it](https://www.youtube.com/watch?v=gbUBTTXuQwI&list=PLLYW3zEOaqlKYku0piyzzLFGpR9VpPvXR) (8 mins)
  - [Helm Architecture](https://helm.sh/docs/architecture/) (**2 mins**)
  - [Helm Concepts and How to Use Helm](https://helm.sh/docs/intro/using_helm/) (**5 min**)
  - [Structure of a Helm Chart](https://helm.sh/docs/topics/charts/) (**1 min**, you can stop after the "The Chart.yaml File" section)
- [**OPTIONAL** [Docs] Helm Commands List](https://helm.sh/docs/helm/#helm)
- [**OPTIONAL** [Docs] Helm Chart Template Guide](https://helm.sh/docs/chart_template_guide/) - Extensive documentation on almost everything you need to know about Helm templating, but its pretty lengthy
- [**OPTIONAL** [Docs] Helm Chart Best Practices](https://helm.sh/docs/chart_best_practices/#the-chart-best-practices-guide)

## What will we do in Guild?
 
### Setup
- [Install `aws-iam-authenticator`](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [Install `helm`](https://helm.sh/docs/intro/install/) 
- [Install `terraform`](https://brewinstall.org/install-terraform-on-mac-with-brew/)
- [For Extra Activities] Install [Docker Desktop](https://docs.docker.com/docker-for-mac/install/)
- Setup an AWS account with `awscli` access on the terminal. You can use the TW Beach account, or your personal one (note: Charges will apply for your personal account)

### End Goal
- Create an EKS cluster using `terraform-aws-eks-module`
- Deploy applications (`CatApplication` and `MeowApplication`)into the cluster using Helm. Docker image tags are provided below:
  - CatApplication: `janesee3/cat-application:1`
  - MeowApplication: `janesee3/meow-application:1`
- Expose the API served by these applications to the internet (both applications listens on port `8080`)
- **Tip:** If you find yourself stuck, please refer to the `suggested-solutions` folder!

### Steps

**Section 1: Spinning Up An EKS Cluster**

- Make a copy of the `eks` folder in your own working directory, fill in the necessary values in the `main.tf` file and create your EKS cluster using terraform.
  - **Tip:** We will be using a two-tiered network to house the Kubernetes worker nodes of your EKS cluster. EKS cluster worker nodes should reside in at least 2 different private subnets to take advantage of the multi availability zone support!
  - **Tip:** You can use [this website](http://www.davidc.net/sites/default/subnets/subnets.html) to help you split the VPC CIDR range
- AWS will take around 15mins to finish creating the cluster. While waiting, proceed to the second section below.
- Once the cluster is successfully created, configure your `kubectl` to point to the newly created cluster and check that the worker nodes are connected.
  - **Tip:** Refer to [this article](https://itnext.io/how-does-client-authentication-work-on-amazon-eks-c4f2b90d943b#609a) to see how you can configure `kubectl` for EKS cluster   

**Section 2: Using Helm**

1. Creating your first Helm Chart 
  
    As a follow up to last week's lesson, let's improve the way we manage our K8S resource YAML files by creating a Helm chart.

    Your task is to templatise the [YAML config files](./helm/raw-files) for `CatApplication` and `MeowApplication` from last week's lesson into two separate Helm charts, one for `cat-application` and one for `meow-application`.
 
    It is very important to go through the materials tagged with **IMPORTANT** above before starting! 
 
    In order to familiarise ourselves with the Go Template syntax used in Helm charts, let's create our own charts from scratch. Don't use the `helm create` command!
 
    Steps:
    - Use the [`helm/sample-application` folder](./helm/sample-application) as a starting point.
    - Find and replace all instances of `sample-application` with your desired chart name! You can rename them to `cat-application` and start templatising the `CatApplication` Kubernetes resources first.
    - Using your understanding of Helm and Go Template, templatise the Kubernetes resource manifests files in [`helm/raw-files`](./helm/raw-files) and place the completed templates in the `helm/sample-application/templates` folder. 
    - When you're done, you should have 2 folders ready, each containing the Helm chart for `CatApplication` and `MeowApplication` separately.
    - **Tip:** Watch [this video](https://www.youtube.com/watch?v=gbUBTTXuQwI&list=PLLYW3zEOaqlKYku0piyzzLFGpR9VpPvXR) to familiarise yourself with Helm and how templating works with it. 
    - **Tip:** Refer to [this documention](https://helm.sh/docs/chart_template_guide/) for help along the way
    - **Tip:** You can use the `helm template` command to check whether your templatised YAML resolves correctly. More information about this command and how it works [here](https://helm.sh/docs/helm/helm_template/).

2. Using the Helm charts you've prepared, install `CatApplication` and `MeowApplication` as Helm releases into your cluster. 
   - **Tip:** When installing a fresh Helm release, you can use either the `helm upgrade` or `helm install` command. However, to update an existing release, you can only use `helm upgrade`. See [here](https://helm.sh/docs/helm/) for more information about each command.
   - You may have noticed that `readinessProbe` is configured for the Pods. This means that we no longer have to manually call the `/meow` or `/cats` endpoint ourselves to check for the Pod's health; we can just rely on the Pod's `READY` metric.
   - **Tip**: For the `helm upgrade` command, can you find out which flag you can add to ensure that `helm` will rollback changes in the event that the upgrade was unsuccessful? (eg. Pods not starting up healthily)  
   
3. Yay! `CatApplication` and `MeowApplication` are now running on the cloud!

   Now, we can continue to use the `port-forward` method from last week to hit the `/meow` endpoint, but since we're running on the cloud now, let's expose these endpoints to the internet instead.

   First, we need to set up a Load Balancer on AWS to receive traffic from the internet and propagate them to the K8S worker nodes accordingly. Next, we need to write routing rules so that we can provide a mapping between the URL paths and our K8S Services.

   Lucky for us, an `Ingress Controller` is what we need to achieve this! There are many Ingress Controllers out there, but for today, we will be using the NGINX Ingress Controller. See here for more information about

   Using the [`nginx-ingress-controller`](https://github.com/helm/charts/tree/master/stable/nginx-ingress) Helm chart, install an ingress controller in your cluster
   - **Tip:** Refer to [this documentation](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/) for guide
   - **Tip:** You can use `helm get manifest <release-name>` command to check what K8S resources were created for that release.
   - How can you check what Load Balancer URL has been provisioned for you after the installation? Remember that we can provision an AWS Load Balancer for the EKS cluster by creating a K8S Service with type `LoadBalancer`.
  
4. Next, write the routing rules that will be consumed by the Ingress Controller.
   - **Tip:** These routing rules are actually a type of K8S resource, called `Ingress`. See [here](https://kubernetes.io/docs/concepts/services-networking/ingress/#types-of-ingress) and [here](https://www.youtube.com/watch?v=VicH6KojwCI) for more information!
   - **Tip:** We should be creating TWO separate `Ingress` resources, one each for the `CatApplication` and `MeowApplication`, so that we can achieve **host-based routing** for the `/meow` and `/cats` endpoints. See [here](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/) for reference.
   - **Tip:** Remember, now that you already have an existing Helm release, you should be using the `helm upgrade` command to apply your updates!
   - Test that your Ingress resources have been correctly configured and applied by using `curl` or accessing the endpoint directly from the browser! 
   

### Extra Activities

1. How can we deploy `CatApplication` and `MeowApplication` in a LOCAL kubernetes cluster by reusing the same Helm charts?
   - **Requirements for the local deployment:**
         1. No `Ingress` resources required, since we will not have an Ingress Controller for a local cluster
         2. `CatApplication` will be using the image `janesee3/cat-application:local`
   - If you haven't already, start up a local Kubernetes cluster using Docker Desktop. Remember to configure `kubectl` to point to the local cluster when that's done.
   - **Tip:** You will need to create a separate Helm values file (eg. `local-cluster.yaml`)  
2. How can we decouple the configurations for application environment variables from the `Deployment` YAML template, and move them to the `values.yaml` file instead?
   - In doing so, we can easily configure different env vars for the Helm release by switching out a different values file.
3. Try to secure the LoadBalancer URL provisioned by the NGINX Ingress Controller with basic authentication by following this guide [here](https://kubernetes.github.io/ingress-nginx/examples/auth/basic/)


## What if I want to know more!?

- [[Hands-on] AWS EKS Workshop](https://eksworkshop.com/) - This workshop covers many different topics on what you can do with EKS
- [Kubernetes Secret](https://kubernetes.io/docs/concepts/configuration/secret/) - Abstraction to store and manage sensitive information in your cluster
- [Kubernetes External Secrets Controller](https://github.com/godaddy/kubernetes-external-secrets) - How to automate the injection of Kubernetes Secret resources into your cluster
- [Getting started with Kubernetes RBAC](https://docs.bitnami.com/kubernetes/how-to/configure-rbac-in-your-kubernetes-cluster/)
- [Kubernetes Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) - Persistent file sharing/storage that can be accessed across different Pods
- [Securing your NGINX Ingress Controller with TLS/HTTPS](https://kubernetes.github.io/ingress-nginx/user-guide/tls/)
- [Introduction to Istio (Service Mesh)](https://www.youtube.com/watch?v=1iyFq2VaL5Y) - Short 3 mins video to give a general overview of what it does
- [Official Docs on what is Istio](https://istio.io/docs/concepts/what-is-istio/) - The overwhelming version of what Istio is. You can read the rest of the [Istio Concepts here](https://istio.io/docs/concepts/) for deeper understanding. 



---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
