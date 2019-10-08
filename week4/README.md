# Week 4: Containerisation
We have talked about deploying your program to AWS in the past two weeks. We have also used the capabilities of the cloud in scaling your application and discussed the basic concepts associated with cloud providers. 

This week, we will talk about containerization to ensure our applications run across platforms, e.g. your IDE and the cloud, reliably and consistently. We will also learn how to best utilize available infrastructure resources.

## What will I learn?
1. Introduction to Containerization
   * History of containers
   * Why Containerization:
   * Dependency isolation 
   * Portability
   * Efficient resource utilization
2. Introduction to Docker
   * Defining your container using Dockerfile
   * Building and publishing docker images

## What should I learn on weekend?
1. [Overview The History of Containers](https://www.redhat.com/en/blog/history-containers) (~15min)
2. [Understanding Containers](https://medium.com/@jessgreb01/what-is-the-difference-between-a-process-a-container-and-a-vm-f36ba0f8a8f7) (~10min)
3. [Getting started with Docker](https://docs.docker.com/get-started/) (~70min)
4. [An Introduction to Containers - deep dive into container internals](https://www.youtube.com/watch?v=sK5i-N34im8) (~60min)

## What will we do in Guild?
**End Goal**:
1. Write Dockerfiles to containerize our application jar with different java version or runtime.
2. Modify our setup to build and push docker images versus deploying jar directly on AWS

**Pre-requisites**:
- Install Docker

**Rough steps**:
- What should be the base image we should use for our spring boot app?
- How do we copy over my compiled jar into the docker container?
- What should be the first command the container should run on startup?
- How do we expose my app running inside the docker container and access the app on my browser?
- How do we modify our vagrant configuration to use the docker image instead of the jar file?
- What if we want to use a different version of Java? Do we need to reinstall the JDK on our EC2 instance?

## What if I want to know more!?
1. Deep Dive into Docker: [The Docker Book](https://www.amazon.com/Docker-Book-Containerization-new-virtualization-ebook/dp/B00LRROTI4) - written step-by-step for system administrators, operations staff on
2. [Docker Training](https://success.docker.com/training/) - compilation of self-paced and instructor-led courses offered by Docker
3. [Creating a Simple Docker Base Image](https://docs.docker.com/develop/develop-images/baseimages/)
4. [10+ Top Open-Source Tools for Docker Security](https://techbeacon.com/security/10-top-open-source-tools-docker-security)

---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
