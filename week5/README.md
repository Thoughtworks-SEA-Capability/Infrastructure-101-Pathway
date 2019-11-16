# Week 5: Kubernetes

## What will I learn?
- What Container Orchestration is
- What Kubernetes is
- How to create a local Kubernetes (K8S) cluster
- How to deploy applications into the cluster
- How to interact with the applications in the cluster
- Basic networking between applications in the cluster
- Some essential `kubectl` commands and Kubernetes configurations

## What should I learn on the weekend?

  - [[Article] What is container orchestration and why it is needed](https://opensource.com/life/16/9/containing-container-chaos-kubernetes) (**~5 mins**)
  - [[Video] Overview of Kubernetes Architecture](https://www.youtube.com/watch?v=8C_SCDbUJTg) - Learn about the main components of a K8s Cluster (**~10 mins**)
  - [[Article] Introduction to Kubernetes Abstractions](https://rtfm.co.ua/en/kubernetes-part-1-architecture-and-main-components-overview/) - Introduction to Pods, Services, Deployments etc (**~15mins**)
  - [[Docs] k8s Pod](https://kubernetes.io/docs/concepts/workloads/pods/pod-overview) **(~5 mins**)
  - [[Video] Breakdown of a Pod spec](https://www.youtube.com/watch?v=T6E2yzlEX0Q&t=82s) (**~7mins**)
  - [[Docs] Breakdown of a Deployment spec](https://devopscube.com/kubernetes-deployment-tutorial/) **(~7 mins**)
  - [[Article] k8s Services Explained with Diagrams](https://medium.com/swlh/kubernetes-services-simply-visually-explained-2d84e58d70e5) (**~10 mins**)

  Optional Readings:
  - **OPTIONAL** [[Docs] Overview of what Kubernetes is and isn't](https://kubernetes.io/docs/concepts/overview/what-is-kubernetes/) (**~10 mins**)
  - **OPTIONAL** [[Video] The Illustrated Children's Guide to Kubernetes](https://www.youtube.com/watch?v=4ht22ReBjno) - Just a fun video that introduces the essential abstractions of Kubernetes (**~9 mins**)
  - **OPTIONAL** [[Video] k8s NodePort Service Explained](https://www.youtube.com/watch?v=5lzUpDtmWgM) - A good step by step explanation of the NodePort Service type (**~14 mins**) 
  - **OPTIONAL** [[Docs] Kubernetes Service](https://kubernetes.io/docs/concepts/services-networking/service/) - Detailed information about everything else that k8s Service can do (**~30mins**)
  

## What will we do in Guild?

### Setup
- Install Docker CE
- Install [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)

### End Goal
- Create your own local cluster
- Deploy highly available applications (`servicea` and `serviceb`) into the cluster
- Configure and interact with these deployed applications

### Steps

1. Start a Kubernetes cluster on your local machine using Docker
   - Enable it here: `Preferences` > `Kubernetes` 
   - You may want to temporarily increase the Memory and CPU allocated for Docker for better performance: `Preferences` > `Advanced`

2. How can configure your local `kubectl` to point to this newly created cluster?
   
3. Now that `kubectl` is pointing to your cluster, what command can you use to check that the cluster indeed has node(s) connected?
   
4. How can we deploy the image `servicea` into the cluster as just a `Pod`?
     - Bonus Question: Which method did you use to deploy the Pod? Can you do it with a single command?

5. `servicea` is serving an endpoint `/getCats`. How can we hit this endpoint from your local machine?
   - There are many ways to do this, but for this step, use the simplest approach!

6. Run the `disaster-a.sh` script.
   
   Oh no! Disaster struck! Your pod has mysteriously disappeared! If this was a public application, millions of cat lovers would be really sad because they can't see cats now.
   
   We need to prevent this from happening! What should we deploy to the cluster to ensure that the `servicea` Pods can be highly available (has more than one Pod and at least one Pod is up at all times)?

7. Now that you have multiple Pods for `servicea`, let's try to hit the `/getCats` endpoint again. 

   How should we choose which Pod's endpoint to hit? Since we learnt from `disaster-a` that Pods may come and go unexpectedly, how can we let Kubernetes help us decide which `servicea` Pod to route our request to so that we can reliably get the response that we need?

8. Deploy `serviceb` in the same way as you did for `servicea` 
   
    - Notice that the Pods for `serviceb` do not start up healthily. How can you debug why the Pods are not starting up correctly?
    
    - The Pods are crashing because it is missing a required environment variable configuration. How can we add this configuration in?
      - Even though we can add the env var when we build application or image, for such environment specific variable, we should aim to only configure them at the point of deployment.

9. `serviceb` has an endpoint `/meow`. It works by calling `servicea` for the list of cats and then processing each of their meows. 
    
    `serviceb` takes in an environment variable, `blabla`, which determines what URL it should use to reach `servicea` and get the cat data.

    Find out what the URL should be and hit the `/meow` endpoint from your machine to see the results.
      - For ease of testing, you can try out `curl` commands from within a `serviceb` Pod to see what works

10. A new version of `serviceb` has just been released! Update your Deployment to use this new image version.
    
    Aaand of course there're some errors and now your Pods are crashing. How can we rollback your deployment to the older working version?

### Extra Activities

1. WIP

## What if I want to know more!?
  - [[Hands-on] Interactive tutorial on the basics of Kubernetes using a local cluster](https://kubernetes.io/docs/tutorials/kubernetes-basics/) (**~2 hours**)
  - [[Hands-on] Getting started with AWS EKS](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html) and [[Hands-on] Deploying sample app with Redis](https://docs.aws.amazon.com/eks/latest/userguide/eks-guestbook.html) (**~1 hour**)
  - [[Course] Linux Foundation K8S Fundamentals](https://training.linuxfoundation.org/training/kubernetes-fundamentals/) (**~35 hours**)
  - [Understanding Kubernetes Networking Model](https://sookocheff.com/post/kubernetes/understanding-kubernetes-networking-model/)
  - [Kubernetes Cluster Authentication](https://kubernetes.io/docs/reference/access-authn-authz/authentication/)


---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
