# Week 1: Linux, VMs

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
- (extra) Packer for automating the creation of machine images

## What should I learn during the weekend?
- Linux:
  - [UNIX Tutorial for Beginners](http://www.ee.surrey.ac.uk/Teaching/Unix/) (Tutorial One to Six, ~ 60 minutes)
  - [UNIX and Linux System Administration Handbook: 2.6 System Management Daemons and 2.7 systemd in detail](https://www.amazon.com/UNIX-Linux-System-Administration-Handbook/dp/0134277554) OR
  - [Intro to Systemd](https://thepracticalsysadmin.com/intro-to-systemd/) (~30min)
- Virtual Machines and Vagrant
  - [What is Immutable Infrastructure?](https://www.digitalocean.com/community/tutorials/what-is-immutable-infrastructure) (~10min)
  - [Virtual Machine](https://en.wikipedia.org/wiki/Virtual_machine) (~10min)
  - [Vagrant Intro](https://www.vagrantup.com/intro) (~45min)
- Ansible
  - [Docs](https://docs.ansible.com/) (Installation, Getting Started, and Playbooks, ~120min)
- (extra) Packer
  - [Intro](https://www.packer.io/intro) (~30min)

## What will we do in Guild?

**End Goal**:
- Automatically run the given `hello-spring-boot-0.1.0.jar` jar file on a local VM, with the desired configuration
- (Extra) Package that VM image into an AMI

**Notes**:
- Jar is a simple SpringBoot Hello World web app: https://spring.io/guides/gs/spring-boot/#scratch
- Jar should be run with your desired configuration in `test.application.properties`

### Pre-requisites
- Know some java and springboot basics (ie. how to run an configure and jar file)
- Install Virtualbox
- Install Vagrant
- Install Ansible
- (extra) Install Packer

### Rough steps:
  - How do we spin up a basic VM using vagrant? How do we copy the jar file in?
  - What dependencies are required to run the jar? How do we install them?
  - How do we automate that installation via shell scripts?
  - What user is running the jar? How do we make it more secure?
  - How can we run our app as a service? What are the benefits?
  - How can we apply configuration to our app?
  - How can we automatically apply that configuration in a reproducible way using Ansible?
  - How can we automatically deliver configuration changes and ensure the app picks them up?
  - (extra) How can we package the resulting VM image for reuse using Packer?

## What if I want to know more!?
- More commandline tricks: [http://conqueringthecommandline.com/book](http://conqueringthecommandline.com/book)


---

*Copyright (c) 2018 ThoughtWorks; for individual use for training purposes and not to be distributed or sublicensed without further authorisation by ThoughtWorks.*
