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

**Note on Helm**

We will be using **Helm 2** for this, not Helm 3 which was recently released. We will be touching on Helm concepts that does not change whether you are using Helm 2 and 3, so don't think that you're learning "outdated tech"! 
Unfortunately, after the release of Helm 3, some of the official documentation for Helm 2 has been misplaced on their website so we have to resort to some third-party guides. 

- [[Video] What is Helm, Why we need it, How to use it](https://www.youtube.com/watch?v=9cwjtN3gkD4) (12 mins)
- **[IMPORTANT]** Helm Basics
  - [Helm Architecture](https://v2.helm.sh/docs/architecture/) (**2 mins**)
  - [Three Big Concepts of Helm](https://v2.helm.sh/docs/using_helm/#three-big-concepts) (**1 min**)
  - [Structure of a Helm Chart](https://helm.sh/docs/topics/charts/) (**1 min**, you can stop after the "The Chart.yaml File" section)
  - [Getting Started With Helm](https://helm.sh/docs/intro/getting_started/) (**5 mins**)
- [How to initialise Helm on your cluster](https://devopscube.com/install-configure-helm-kubernetes/) (**~10 mins**)
- [Finding Third Party Helm Charts](https://v2.helm.sh/docs/using_helm/#helm-search-finding-charts) (**2 mins**)
- [How to Install a Helm Chart](https://v2.helm.sh/docs/using_helm/#helm-install-installing-a-package) (**3 mins**)
- [**OPTIONAL** [Docs] Helm Command Basic Usages](https://v2.helm.sh/docs/using_helm/)
- [**OPTIONAL** [Docs] Helm Commands List](https://v2.helm.sh/docs/helm/#helm)
- [**OPTIONAL** [Docs] Helm Chart Template Guide](https://helm.sh/docs/topics/chart_template_guide/) - Extensive documentation on almost everything you need to know about Helm templating, but its pretty lengthy
- [**OPTIONAL** [Docs] Helm Chart Best Practices](https://v2.helm.sh/docs/chart_best_practices/#the-chart-best-practices-guide)

## What will we do in Guild?
 
### Setup
- [Install `aws-iam-authenticator`](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
- Install `helm` **v2.16.X**
  - Please run `brew install helm@2` followed by `brew link --force helm@2`
- [Install `terraform`](https://brewinstall.org/install-terraform-on-mac-with-brew/)
- Install [Docker Desktop](https://docs.docker.com/docker-for-mac/install/)
- Setup an AWS account with `awscli` access on the terminal. You can use the TW Beach account, or your personal one (note: Charges will apply for your personal account!)

### End Goal
- Create an EKS cluster using `terraform-aws-eks-module`
- Deploy applications (`CatApplication` and `MeowApplication`)into the cluster using Helm. Docker image tags are provided below:
  - CatApplication: `janesee3/cat-application:1`
  - MeowApplication: `janesee3/meow-application:1`
- Expose application endpoints to the internet (both applications listens on port `8080`)
- Use the same set of Helm Charts to deploy a similar setup in your local cluster
- **Tip:** If you find yourself stuck, please refer to the `suggested-solutions` folder!


### Steps

**PRE-REQ**

Make a copy of the `eks` folder in your own working directory, fill in the necessary values in the `main.tf` file and create your EKS cluster using terraform.
   - **Tip:** We will be using a two-tiered network to house the Kubernetes worker nodes of your EKS cluster. EKS cluster worker nodes should reside in at least 2 different private subnets to take advantage of the multi availability zone support!
   - **Tip:** You can use [this website](http://www.davidc.net/sites/default/subnets/subnets.html) to help you split the VPC CIDR range
   - Once your terraform command runs to completion successfully, configure your `kubectl` to point to the newly created cluster and check that the worker nodes are connected.
   - **Tip:** Refer to [this article](https://itnext.io/how-does-client-authentication-work-on-amazon-eks-c4f2b90d943b#609a) to see how you can configure `kubectl` for EKS cluster
  
While waiting for the cluster to be provisioned: 

1. We are going to improve the way we manage our K8S resource YAML files by creating a Helm chart!
   - **Tip:** You can watch [this video](https://www.youtube.com/watch?v=9cwjtN3gkD4) to understand why we need Helm (its 12 mins long so you either skim through it or watch it another day!)
   
   Your task is to convert the [YAML config files](./helm/raw-files) for `CatApplication` and `MeowApplication` from last week into two separate Helm charts.

   It is very important to go through the materials tagged with **IMPORTANT** above before starting! 

    In order to familiarise ourselves with the Go Template syntax used in Helm charts, let's create our own charts from scratch. Don't use the `helm create` command!

      - Use the [`helm/sample-application`](./helm/sample-application) folder as a starting point. (Remember to replace all instances of `sample-application` with your desired chart name!
      - See [`helm/raw-files`](./helm/raw-files) for the YAML config files required to deploy `CatApplication` and `MeowApplication`. 
      - **Tip:** Refer to [this documention](https://helm.sh/docs/topics/chart_template_guide/) for help along the way!
      - **Tip:** You can use the `helm template` command to check whether your templatized YAML resolves correctly. More information about this command and how it works [here](https://v2.helm.sh/docs/helm/#helm-template).
   
2. Initialise `helm` in your EKS cluster
   
   In Helm 2, there is a server-side component known as `Tiller`, which is to be installed in the kubernetes cluster you're working on. However, in Helm 3, they've removed the need for a server-side component, so you do not have to bother youself much with Tiller moving forward.

   Simply follow the steps below to initialise `helm` with Tiller, and move on to the next step!

   - Download / copy the contents of the [`helm/helm-rbac.yaml`](./helm/helm-rbac.yaml) into your machine.
   - Run `kubectl apply -f helm-rbac.yaml` to install the required K8S ServiceAccount for the Tiller component that will be running in your cluster.
   - Run `helm init --service-account=tiller`
   - See [here](https://devopscube.com/install-configure-helm-kubernetes/) if you want to understand more about this init process!

3. Install `CatApplication` and `MeowApplication` as Helm releases into the cluster. 
   - **Tip:** See [here](https://v2.helm.sh/docs/helm/#helm-install) for information about the `helm install` command.
   - **Bonus**: What flags can you add to the `helm install` command to ensure that `helm` will rollback whatever resources that were created in the event that the deployment was unsuccessful? (eg. Pods not starting up healthily)  
   - You may have noticed that the `readinessProbe` setting is configured for the Pods. This means that we no longer have to manually call the `/meow` or `/cats` endpoint ourselves to check for the Pod's health; we can just rely on the Pod's `READY` metric.
   
4. Yay! `CatApplication` and `MeowApplication` is now running on the cloud! Now, we could hit the `/meow` endpoint using the `port-forward` method last week, but since we're running on the cloud now, how can we expose these endpoints to the internet?

   First, we need to setup a Load Balancer on AWS to receive traffic from the internet and propagate them to the K8S worker nodes accordingly. Next, we need to write routing rules so that we can provide a mapping between the URL paths and our K8S Services.

   Lucky for us, an `Ingress Controller` is what we need to achieve this! There are many Ingress Controllers out there, but for today, we will be using the NGINX Ingress Controller. See here for more information about

   Using the [`nginx-ingress-controller`](https://github.com/helm/charts/tree/master/stable/nginx-ingress) Helm chart, install an ingress controller in your cluster
   - **Tip:** Refer to [this documentation](https://kubernetes.github.io/ingress-nginx/user-guide/basic-usage/) for guide
   - **Tip:** You can use `helm get manifest <release-name>` command to check what K8S resources were created for that release.
   - How can you check what Load Balancer URL has been provisioned for you after the installation? Remember that we can provision an AWS Load Balancer for the EKS cluster by creating a K8S Service with type `LoadBalancer`.
  
5. Next, write the routing rules that will be consumed by the Ingress Controller.
   - **Tip:** These routing rules are actually a type of K8S resource, called `Ingress`. See [here](https://kubernetes.io/docs/concepts/services-networking/ingress/#types-of-ingress) and [here](https://www.youtube.com/watch?v=VicH6KojwCI) for more information!
   - **Tip:** We want to create TWO separate `Ingress` resources, one each for the `CatApplication` and `MeowApplication`, so as to achieve **host-based routing** for the `/meow` and `/cats` endpoints. See [here](https://kubernetes.io/docs/tasks/access-application-cluster/ingress-minikube/) for reference.
   - **Tip:** Where should the `Ingress` YAML files be stored in, and how can they be applied to the cluster? See [here](https://v2.helm.sh/docs/helm/#helm-upgrade) for reference.
   - Test that your Ingress resources are correct with `curl` or accesing the endpoint directly from the browser! 
6. How can we deploy the `CatApplication` and `MeowApplication` in a LOCAL kubernetes cluster by reusing the same Helm charts?
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
