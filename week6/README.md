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
- [Creating an EKS cluster using Terraform (without module)](https://youtu.be/PjxJzyP_bdU?t=762) (**watch from 12:47 ~ 21:10**)
- [**How** Client-Side Authentication for EKS works](https://itnext.io/how-does-client-authentication-work-on-amazon-eks-c4f2b90d943b#609a) (**~15 mins**)
- [[Recap] K8S Services Explained with Diagrams](https://medium.com/swlh/kubernetes-services-simply-visually-explained-2d84e58d70e5) (**~10 mins**)
- [[Video] K8S Ingress Explained for Beginners](https://www.youtube.com/watch?v=VicH6KojwCI) (**23 mins**)
- [K8S Ingress](https://kubernetes.io/docs/concepts/services-networking/ingress/) - Official Documentation on what Ingress is
- [Basic Host Based Routing with NGINX Ingress Controller](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/) (**5 mins**)
- [**OPTIONAL** [Video] Thorough Overview of EKS](https://www.youtube.com/watch?v=tNlbcBrx_s8) (**40 mins**)
- [**OPTIONAL** How NGINX Ingress Controller Works](https://kubernetes.github.io/ingress-nginx/how-it-works/)
  

### Helm

Note: We will be learning Helm 2, not Helm 3 which was recently released. Unfortunately, after the release of Helm 3, much of the official documentation for Helm 2 has been misplaced on their official website so we have to resort to third-party guides.

- [[Video] What is Helm, Why we need it, How to use it](https://www.youtube.com/watch?v=9cwjtN3gkD4) (12 mins)
- [Basic concepts of Helm](https://v2.helm.sh/docs/using_helm/) (15 mins)
- [How to initialise Helm on your cluster](https://devopscube.com/install-configure-helm-kubernetes/) (**~10 mins**)
- [**OPTIONAL** [Docs] Helm Commands](https://v2.helm.sh/docs/helm/#helm)
- [**OPTIONAL** [Docs] Helm Chart Template Guide](https://helm.sh/docs/topics/chart_template_guide/) - Extensive documentation on almost everything you need to know about Helm templating, but its pretty lengthy
- [**OPTIONAL** [Docs] Helm Chart Best Practices](https://v2.helm.sh/docs/chart_best_practices/#the-chart-best-practices-guide)

## What will we do in Guild?
 
### Setup
- [Install `aws-iam-authenticator`](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- [Install `helm`](https://github.com/helm/helm#install)
- [Install `terraform`](https://brewinstall.org/install-terraform-on-mac-with-brew/)
- Install [Docker Desktop](https://docs.docker.com/docker-for-mac/install/)
- Setup your own personal AWS account with `awscli` access, we cannot use the Beach account because it does not have enough rights 

### End Goal
- Create an EKS cluster using `terraform-aws-eks-module`
- Deploy applications (`CatApplication` and `MeowApplication`)into the cluster using Helm. Docker image tags are provided below:
  - CatApplication: `janesee3/cat-application:1`
  - MeowApplication: `janesee3/meow-application:1`
- Expose application endpoints to the internet (both applications listens on port `8080`)
- Use the same set of Helm Charts to deploy a similar setup in your local cluster
- **Tip:** If you find yourself stuck, please refer to the `suggested-solutions` folder!


### Steps

1. Make a copy of the `eks` folder in your own working directory, fill in the necessary values in the `main.tf` file and create your EKS cluster using terraform.
   - **Tip:** You can use [this website](http://www.davidc.net/sites/default/subnets/subnets.html) to help you split the VPC CIDR range
   - Once your terraform command runs to completion successfully, configure your `kubectl` to point to the newly created cluster and check that the worker nodes are connected.
  
While waiting for the cluster to be provisioned: 

1. Convert the YAML configs for the `CatApplication` and `MeowApplication` into a Helm chart each.

    In order to familiarise ourselves with the Go Template syntax used in Helm charts, let's create our own charts from scratch. Don't use the `helm create` command!
      - Use the `helm/sample-application` folder as a starting point. (Remember to replace all instances of `sample-application` with your desired name!)
      - Refer to `helm/raw-files` for the actual YAML configs required to deploy `CatApplication` and `MeowApplication`.
      - **Tip:** Refer to [this documention](https://helm.sh/docs/topics/chart_template_guide/) for help along the way!
      - **Tip:** You can use the `helm template` command to check whether your templatized YAML resolves correctly
   
2. Initialise `helm` in your EKS cluster, and install `CatApplication` and `MeowApplication` as Helm releases into the cluster. 
   - **Tip:** Refer to [this article](https://devopscube.com/install-configure-helm-kubernetes/) for instructions to initialise Tiller
   - **Bonus**: What flags can you add to the `helm install` command to ensure that `helm` will rollback whatever resources that were created in the event that the deployment was unsuccessful (eg. Pods not starting up healthily)  
   - You may have noticed that the `readinessProbe` setting is configured for the Pods. This means that we no longer have to manually call the `/meow` or `/cats` endpoint ourselves to check for the Pod's health; we can just rely on the Pod's `READY` metric.
3. Using the [`nginx-ingress-controller`](https://github.com/helm/charts/tree/master/stable/nginx-ingress) Helm chart, install an ingress controller in your cluster
   - **Tip:** Refer to [this documentation](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/) for guide
   - How can you check what url has been provisioned for you after the installation?
4. Write two separate `Ingress` resources, one each for the `CatApplication` and `MeowApplication`, so as to achieve host-based routing for the `/meow` and `/cats` endpoints
   - Where should the `Ingress` YAML configs be created in, and how can they be applied to the cluster?
   - Test that your Ingress resources are correct with `curl` commands from your machine!
5. How can we deploy the `CatApplication` and `MeowApplication` in a LOCAL kubernetes cluster by reusing the same Helm charts?
   - **Requirements for the local deployment:**
      1. No `Ingress` resources are required, since we will not have an Ingress Controller for a local cluster
      2. `CatApplication` will be using the image `janesee3/cat-application:local`
   - If you haven't already, start up a local Kubernetes cluster using Docker Desktop. Remember to configure your `kubectl` to point to the local cluster afterwards!
   - **Tip:** You will need to create a separate Helm values file (eg. `local-cluster.yaml`)
   

### Extra Activities

1. How can we decouple the configurations for application environment variables from the `Deployment` YAML template, and move them to the `values.yaml` file instead?
   - In doing so, we can easily configure different env vars for the Helm release by switching out a different values file.
2. Try to secure the LoadBalancer URL provisioned by the NGINX Ingress Controller with basic authentication by following this guide [here](https://kubernetes.github.io/ingress-nginx/examples/auth/basic/)


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
