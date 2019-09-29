# Week 1:

## What will I learn?
We'll cover some Linux concepts and learn about virtual machines (VMs) and immutable infrastructure.

Linux concepts:
- basic commands
- port forwarding
- the filesystem
- users, groups and permissions
- process management and systemd

Technologies covered:

- Vagrant for managing virtualization configuration, allowing you to easily configure and spin up VMs locally
- Ansible for more complex configuration management and app deployment
- Packer for automating the creation of machine images

## What should I learn on weekend?


## What will we do in Guild?

**End Goal**: Automatically run the given `hello-spring-boot-0.1.0.jar` jar file on a local VM, with the desired configuration, and package that VM image into an AMI

- Jar is a simple SpringBoot Hello World web app: https://spring.io/guides/gs/spring-boot/#scratch
- Desired configuration:

- Rough steps:
  - How do we spin up a basic VM using vagrant?
  - What dependencies are required to run the jar? How do we install them?
  - What user is running the jar? How do we make it more secure?
  - How do we automate that installation via shell scripts?
  - How can we configure our app to ....
  - How can we automatically apply that configuration in a reproducible way using Ansible?
  - How can we package the resulting VM image for reuse using Packer?

## What if I want to know more!?

---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
