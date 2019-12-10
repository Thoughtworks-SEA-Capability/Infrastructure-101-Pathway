# Week 7: CD, GO CD

## What will I learn?

We will cover some basic knowledge about differences between CI/CD and Continuous Delivery concepts.
We are going to use GoCD as our Continuous Delivery tool.

- Understand what's the difference between CI/CD and Continuous Delivery?
- What and how I can create a pipeline?
- Understand how we can create GoCD pipeline through UI and yaml?
- What is a Value Stream Map?

## What should I learn on weekend?

- Continuous Delivery: (Video)
  - [Continuous Delivery 101 (Part 1)](https://www.youtube.com/watch?v=HnWuIjUw_Q8) (~6 minutes)
  - [Continuous Delivery 101 (Part 2)](https://www.youtube.com/watch?v=a9r-lXLDLvk) (~9 minutes)
  - [Continuous Delivery 101 (Part 3)](https://www.youtube.com/watch?v=S0g91mryV4c) (~5 minutes)
  - [Continuous Delivery 101 (Part 4)](https://www.youtube.com/watch?v=5I6PlldXOpY) (~5 minutes)
  - [Continuous Delivery 101 (Part 5)](https://www.youtube.com/watch?v=blkMohClA6M) (~5 minutes)
- Continuous Delivery (Article)
  - [Continuous Delivery Pattern](https://continuousdelivery.com/implementing/patterns/) (~9 minutes)
- More about GoCD
  - [Fan in Fan out](https://www.gocd.org/2017/04/17/build-propagation-using-fan-in-fan-out.html)
  - [GoCD agents setup](https://www.gocd.org/2019/09/17/configure-gocd-agents-kubernetes-static-elastic/)
  - [Install GoCD server on k8s](https://github.com/helm/charts/tree/master/stable/gocd) . Note: the command available was for Helm 2. Refer to the week 7 folder under `Infrastructure-101-Practise` to know more about

- Understand how we can do Infrastructure as a Code with GoCD?
  - [Introduction to GoCD](https://www.gocd.org/why-gocd/)
  - [GoCD Test Drive](https://www.gocd.org/test-drive-gocd/)
  - [GoCD Yaml Documentation](https://github.com/tomzo/gocd-yaml-config-plugin)
  - [Pipeline as a code](https://docs.gocd.org/current/advanced_usage/pipelines_as_code.html)

## What will we do in Guild?

- Deploy GoCD server and agent to [your local machine](https://www.gocd.org/test-drive-gocd.html)
- Familiarise with GoCD by creating a simple pipeline using its UI
- Configure pipeline as a code
- Writing some basic GoCD yaml file to deploy the application to your existing Kubernetes cluster
- Explore how you can structure your pipelines

## Preparation work

As we are going to deploy the existing applications you've exposed to from the previous guild.
Do prepare the following things which we can discussed together as a team before

1. How do you want to structure your deployment starting from the committing your code to repo to kubernetes deployment

2. Create scripts to help you aid the deployment steps

## Practises

We will be exploring GoCD UI to create pipeline at the start to get familiarise with GoCD components and jargon.
Followed by Pipeline as a Code with YAML configuration.

Exercise: GoCD UI
-
*Objective:* We are going to create a pipeline which will echo "Hello World"

Rough steps:
1. How do I assign an agent to perform the task?
1. How do I create a task to echo "Hello World"?
1. Where do I run my script to echo "Hello World"?
1. Where do I see the log of what I have executed?

Exercise: Team sharing on the pipeline structure
-
*Objective:* Exploring how you can structure your pipelines


Exercise: Pipeline as a Code (YAML)
-
*Note:* Refer to GoCD YAML configuration link above to figure out how you can write your YAML pipeline to be

*Objective:* We will be deploying the applications from the previous guild via pipeline to kubernetes cluster

Rough steps:
1. What file extension do I need to create my pipeline as a code?
1. How can I tell GoCD which configuration repository I am interested in to pull my pipeline as a code?
1. How can I tell GoCD which application repository I am interested in to deploy my application?
1. How can I assign my agent to perform task through YAML?
1. How should I sequence my pipelines to be?
1. How should I structure my shell scripts?


## What if I want to know more!?

You can deploy GoCD server to kubernetes with elastic agents.
There is a reference setup you could refer to at `Infrastructure-101-Practise` repository.

---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
